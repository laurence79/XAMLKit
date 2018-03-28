//
//  XAMLPropertyDefinition.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import "XAMLObjectDefinition.h"
#import "XAMLPropertyDefinition.h"

@implementation XAMLPropertyDefinition

- (instancetype)initWithObjectDefinition:(XAMLObjectDefinition *)objectDefinition propertyName:(NSString *)propertyName {
    self = [super init];
    if (self) {
        _owningObject = objectDefinition;
        _name = propertyName;
    }
    return self;
}

- (id)createValue {
    return [self createValueWithValue:_value];
}

- (id)createValueWithValue:(id)value {
    Class class = NSClassFromString(_owningObject.className);
    Class propertyClass = [class xaml_classForPropertyName:_name];
    
    if (propertyClass == [XAMLObjectDefinition class]) {
        //template
        return value;
    }
    else if ([value isKindOfClass:[NSString class]]) {
        // string literal
        if (propertyClass && propertyClass != [NSString class]) {
            return [propertyClass xaml_withLiteral:value];
        }
        else
        {
            id<XAMLConverter> converter = [class xaml_converterForPropertyName:_name];
            if (converter) {
                return [converter convertFromString:value];
            }
            else {
                return value;
            }
        }
    }
    else if ([value isKindOfClass:[XAMLObjectDefinition class]]) {
        // child xaml
        XAMLObjectDefinition * childValue = (XAMLObjectDefinition *)value;
//        if ([childValue hasPropertyNamed:kXAMLKeyProperty]) {
//            // create a single item dictionary
//            NSString * key = [childValue getOrCreatePropertyWithName:kXAMLKeyProperty].value;
//            //[childValue deletePropertyNamed:kXAMLKeyProperty];
//            return @{key:[childValue createObject]};
//        }
//        else {
            return [childValue createObject];
//        }
    }
    else if ([value isKindOfClass:[NSArray class]]) {
        // array of any of the above
        NSArray * arrayValue = (NSArray *)value;
        
        // check for keys to see if we should create a dictionary
        if (arrayValue.count > 0 && [arrayValue[0] isKindOfClass:XAMLObjectDefinition.class] && [(XAMLObjectDefinition *)arrayValue[0] hasPropertyNamed:kXAMLKeyProperty]) {
            
            NSMutableDictionary * finalDict = [NSMutableDictionary new];
            for (NSObject * child in arrayValue) {
                
                // check the child is dictionary compliant - has a xaml_key
                if (![child isKindOfClass:XAMLObjectDefinition.class] || ![(XAMLObjectDefinition *)child getOrCreatePropertyWithName:kXAMLKeyProperty].value) {
                    [NSException raise:NSGenericException format:@"%@ must be set on all children of a dictionary", kXAMLKeyProperty];
                    return nil;
                }
                
                XAMLObjectDefinition * childObject = (XAMLObjectDefinition *)child;
                NSString * key = [childObject getOrCreatePropertyWithName:kXAMLKeyProperty].value;
                //[childObject deletePropertyNamed:kXAMLKeyProperty];
                
                [finalDict setObject:[self createValueWithValue:child] forKey:key];
            }
            return finalDict;
        }
        else {
            NSMutableArray * finalArray = [NSMutableArray new];
            for (id obj in (NSArray *)value) {
                [finalArray addObject:[self createValueWithValue:obj]];
            }
            return finalArray;
        }
    }
    else {
        return value;
    }
}

- (void)setOrAddValue:(id)value {
    if (!_value) {
        _value = value;
    }
    else if ([_value isKindOfClass:NSMutableArray.class]) {
        [(NSMutableArray *)_value addObject:value];
    }
    else {
        NSMutableArray * arr = [@[_value, value] mutableCopy];
        _value = arr;
    }
}

@end
