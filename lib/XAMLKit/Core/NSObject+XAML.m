//
//  NSObject+XAML.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import <objc/runtime.h>

@implementation NSObject (XAML)

- (NSString *)xaml_key {
    return objc_getAssociatedObject(self, @selector(xaml_key));
}

- (void)setXaml_key:(NSString *)xaml_key {
    objc_setAssociatedObject(self, @selector(xaml_key), xaml_key, OBJC_ASSOCIATION_COPY);
}

+ (Class)xaml_classForPropertyName:(NSString *)propertyName {
    
    NSMutableArray * chain = [[propertyName componentsSeparatedByString:@"."] mutableCopy];
    Class classToQuery = self;
    while (chain.count > 1) {
        classToQuery = [classToQuery xaml_classForPropertyName:chain[0]];
        [chain removeObjectAtIndex:0];
    }
    if (!classToQuery) {
        return nil;
    }
    propertyName = chain[0];
    propertyName = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                         withString:[[propertyName substringToIndex:1] capitalizedString]];
    SEL prop = NSSelectorFromString([NSString stringWithFormat:@"xaml_classFor%@", propertyName]);
    if ([classToQuery respondsToSelector:prop]) {
        return [classToQuery performSelector:prop];
    }
    else if ([classToQuery superclass]) {
        return [[classToQuery superclass] xaml_classForPropertyName:propertyName];
    }
    return nil;
}

+ (nullable id<XAMLConverter>)xaml_converterForPropertyName:(nonnull NSString *)propertyName {
    
    NSMutableArray * chain = [[propertyName componentsSeparatedByString:@"."] mutableCopy];
    Class classToQuery = self;
    while (chain.count > 1) {
        classToQuery = [classToQuery xaml_classForPropertyName:chain[0]];
        [chain removeObjectAtIndex:0];
    }
    if (!classToQuery) {
        return nil;
    }
    propertyName = chain[0];
    propertyName = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                         withString:[[propertyName substringToIndex:1] capitalizedString]];
    
    SEL prop = NSSelectorFromString([NSString stringWithFormat:@"xaml_converterFor%@", propertyName]);
    if ([classToQuery respondsToSelector:prop]) {
        return [classToQuery performSelector:prop];
    }
    else if ([classToQuery superclass]) {
        return [[classToQuery superclass] xaml_converterForPropertyName:propertyName];
    }
    return nil;
}

+ (NSString *)xaml_defaultContentPropertyName {
    [NSException raise:NSGenericException format:@"%@ does not have a default content property.", NSStringFromClass(self)];
    return nil;
}

+ (nonnull instancetype)xaml_withAttributes:(nonnull NSDictionary<NSString *, NSObject *> *)attributes {
    id obj = [[self alloc] initWithXAMLAttributes:attributes];
    return obj;
}

- (void)xaml_applyAttributes:(NSDictionary<NSString *,NSObject *> *)attributes {
    for (NSString * key in attributes) {
        [attributes[key] xaml_applyToProperty:key ofObject:self];
    }
}

- (void)xaml_applyToProperty:(nonnull NSString *)propertyName ofObject:(NSObject *)object {
    [object setValue:self forKeyPath:propertyName];
}

+ (nonnull instancetype)xaml_withLiteral:(nonnull NSString *)literal {
    return [[self alloc] initWithXAMLLiteral:literal];
}

- (instancetype)initWithXAMLAttributes:(NSDictionary<NSString *,NSObject *> *)attributes {
    self = [self init];
    if (self) {
        [self xaml_applyAttributes:attributes];
    }
    return self;
}

- (instancetype)initWithXAMLLiteral:(NSString *)literal {
    self = [self init];
    return self;
}

@end
