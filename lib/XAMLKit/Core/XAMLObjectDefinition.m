//
//  XAMLObjectDefinition.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import "XAMLErrors.h"
#import "XAMLObjectDefinition.h"

@interface XAMLObjectDefinition()

@property (copy) NSString * className;

@end

@implementation XAMLObjectDefinition {
    NSMutableDictionary<NSString *, XAMLPropertyDefinition *> * _innerProperties;
}

- (instancetype)initWithClassName:(NSString *)className {
    self = [super init];
    if (self) {
        _className = className;
        _innerProperties = [NSMutableDictionary new];
    }
    return self;
}

- (XAMLPropertyDefinition *)getOrCreatePropertyWithName:(NSString *)name {
    XAMLPropertyDefinition * prop = _innerProperties[name];
    if (!prop) {
        prop = [[XAMLPropertyDefinition alloc] initWithObjectDefinition:self propertyName:name];
        _innerProperties[name] = prop;
    }
    return prop;
}

- (id)createObject {
    Class targetClass = NSClassFromString(_className);
    if (!targetClass) {
        [NSException raise:NSGenericException format:@"%@ is not a valid class", _className];
        return nil;
    }
    NSMutableDictionary * createdProperies = [self createProperties];
    return [targetClass xaml_withAttributes:createdProperies];
}

- (NSMutableDictionary<NSString *,id> *)createProperties {
    NSMutableDictionary * createdProperies = [NSMutableDictionary new];
    for (XAMLPropertyDefinition * prop in [_innerProperties allValues]) {
        createdProperies[prop.name] = [prop createValue];
    }
    return createdProperies;
}

- (BOOL)hasPropertyNamed:(NSString *)named {
    return _innerProperties[named] != nil;
}

+ (XAMLObjectDefinition *)objectDefinitionWithClassName:(NSString *)className {
    return [[self alloc] initWithClassName:className];
}

@end
