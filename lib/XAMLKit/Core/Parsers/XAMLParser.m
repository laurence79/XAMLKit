//
//  XAMLXMLParser.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import <objc/runtime.h>
#import "XAMLErrors.h"
#import "XAMLObjectDefinition.h"
#import "XAMLPropertyDefinition.h"
#import "XAMLParser.h"

@implementation XAMLParser {
    void (^_completion)(XAMLObjectDefinition *, NSError *);
    XAMLObjectDefinition * _currentObject;
    XAMLONParser * _currentONParser;
    NSError * _error;
    NSMutableArray<XAMLObjectDefinition *> * _objectStack;
    NSXMLParser * _parser;
    XAMLObjectDefinition * _rootObject;
    NSURL * _url;
}

- (instancetype)initWithFilePath:(NSString *)filePath {
    self = [super init];
    if (self) {
        _url = [NSURL fileURLWithPath:filePath];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        if (!bundle) {
            bundle = [NSBundle mainBundle];
        }
        _url = [bundle URLForResource:name withExtension:nil];
        if (!_url) {
            [NSException raise:NSGenericException format:@"Resource name %@ is not valid", name];
        }
    }
    return self;
}

- (void)endWithErrorMessage:(NSString *)errorMessage {
    NSString *desc = [NSString stringWithFormat:@"A parse error occurred at line %ld, column %ld. %@",
                      (long)[_parser lineNumber],
                      (long)[_parser columnNumber],
                      errorMessage];
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
    
    _error = [NSError errorWithDomain:kAppErrorDomain code:-101 userInfo:userInfo];
    
    // prevent abort sending another error to us
    _parser.delegate = nil;
    
    [_parser abortParsing];
    
    if (_currentONParser) {
        [_currentONParser abortParsing];
    }
}

- (XAMLObjectDefinition *)parseWithError:(NSError *__autoreleasing *)error {
    __block XAMLObjectDefinition * result;
    
    [self parseWithCompletion:^(XAMLObjectDefinition *obj, NSError *error) {
        result = obj;
        error = error;
    }];
    
    return result;
}

- (void)parseWithCompletion:(void (^)(XAMLObjectDefinition *, NSError *))completion {
    _completion = completion;
    _objectStack = [NSMutableArray new];
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:_url];
    [_parser setDelegate:self];
    [_parser parse];
    if (completion) {
        completion(_rootObject, _error);
    }
}

- (XAMLPropertyDefinition *)currentPropertyForObjectDefinition:(XAMLObjectDefinition *)objectDefinition {
    return objc_getAssociatedObject(objectDefinition, @selector(currentPropertyForObjectDefinition:));
}

- (void)setCurrentProperty:(XAMLPropertyDefinition *)currentProperty forObjectDefinition:(XAMLObjectDefinition *)objectDefinition {
    objc_setAssociatedObject(objectDefinition, @selector(currentPropertyForObjectDefinition:), currentProperty, OBJC_ASSOCIATION_RETAIN);
}

- (void)beginClassWithName:(NSString *)className {
    Class class = NSClassFromString(className);
    if (!class) {
        [self endWithErrorMessage:[NSString stringWithFormat:@"%@ is not a valid class name", className]];
        return;
    }
    
    id obj = [XAMLObjectDefinition objectDefinitionWithClassName:className];
    [_objectStack addObject:obj];
    [self addPropertyValue:obj];
    _currentObject = obj;
}

- (void)endClass {
    if ([self currentPropertyForObjectDefinition:_currentObject]) {
        // default property
        [self endProperty];
    }
    [_objectStack removeLastObject];
    _currentObject = [_objectStack lastObject];
}

- (void)beginPropertyWithName:(NSString *)propertyName {
    [self setCurrentProperty:[_currentObject getOrCreatePropertyWithName:propertyName] forObjectDefinition:_currentObject];
}

- (void)addPropertyValue:(id)value {
    if (![self currentPropertyForObjectDefinition:_currentObject]) {
        if (!_currentObject) {
            //root
            _rootObject = value;
        }
        else {
            // default property
            Class targetClass = NSClassFromString(_currentObject.className);
            NSString * defaultProp = [targetClass xaml_defaultContentPropertyName];
            if (defaultProp) {
                [self beginPropertyWithName:defaultProp];
            }
            else {
                [self endWithErrorMessage:[NSString stringWithFormat:@"Class %@ does not have a default property", _currentObject.className]];
            }
        }
    }
    
    // repeating the if because it _may_ now have a value
    XAMLPropertyDefinition * prop = [self currentPropertyForObjectDefinition:_currentObject];
    if (prop) {
        [prop setOrAddValue:value];
    }
}

- (void)endProperty {
    [self setCurrentProperty:nil forObjectDefinition:_currentObject];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributes {
    
    if (_currentObject && [elementName hasPrefix:[_currentObject.className stringByAppendingString:@"."]]) {
        // explicit property
        NSString * propertyName = [elementName substringFromIndex:_currentObject.className.length + 1];
        NSAssert(!attributes || attributes.count == 0, @"Property elements can not have attributes");
        [self beginPropertyWithName:propertyName];
    }
    else {
        [self beginClassWithName:elementName];
        
        for (NSString * key in attributes) {
            [self beginPropertyWithName:key];
            NSString * propertyValue = attributes[key];
            
            if ([propertyValue hasPrefix:@"{"] && [propertyValue hasSuffix:@"}"]) {
                // object notation
                _currentONParser = [[XAMLONParser alloc] initWithXAMLString:propertyValue delegate:self];
                [_currentONParser parse];
            }
            else {
                [self addPropertyValue:propertyValue];
            }
            
            [self endProperty];
        }
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName hasPrefix:[_currentObject.className stringByAppendingString:@"."]]) {
        // explicit property
        [self endProperty];
    }
    else {
        [self endClass];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)error {
    [self endWithErrorMessage:[NSString stringWithFormat:@"%@", error]];
}

#pragma mark - XAMLONParserDelegate

- (void)xamlONParser:(nonnull XAMLONParser *)parser didBeginElement:(nonnull NSString *)elementName {
    [self beginClassWithName:elementName];
}

- (void)xamlONParser:(nonnull XAMLONParser *)parser didBeginProperty:(nullable NSString *)propertyName {
    [self beginPropertyWithName:propertyName];
}

- (void)xamlONParser:(nonnull XAMLONParser *)parser literalPropertyValue:(nullable NSString *)propertyValue {
    [self addPropertyValue:propertyValue];
}

- (void)xamlONParserDidEndProperty:(nonnull XAMLONParser *)parser {
    [self endProperty];
}

- (void)xamlONParserDidEndElement:(nonnull XAMLONParser *)parser {
    [self endClass];
}

- (void)xamlONParser:(nonnull XAMLONParser *)parser parseErrorOccurred:(nonnull NSError *)error {
    [self endWithErrorMessage:error.localizedDescription];
}
@end
