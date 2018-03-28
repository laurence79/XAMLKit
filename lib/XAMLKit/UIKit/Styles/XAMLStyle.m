//
//  XAMLStyle.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "ClassConverter.h"
#import "NSObject+XAML.h"
#import "NSObject+Resources.h"
#import "XAMLStyle.h"

@implementation XAMLStyle {
    NSArray<XAMLStyleSetter *> * _setters;
    NSArray<XAMLDataTrigger *> * _triggers;
}

- (NSArray<XAMLStyleSetter *> *)setters {
    return _setters;
}

- (void)setSetters:(NSArray<XAMLStyleSetter *> *)setters {
    if (![setters isKindOfClass:[NSArray class]]) {
        _setters = @[(XAMLStyleSetter *)setters];
    }
    else {
        _setters = setters;
    }
}

- (NSArray<XAMLDataTrigger *> *)triggers {
    return _triggers;
}

- (void)setTriggers:(NSArray<XAMLDataTrigger *> *)triggers {
    if (![triggers isKindOfClass:[NSArray class]]) {
        _triggers = @[(XAMLDataTrigger *)triggers];
    }
    else {
        _triggers = triggers;
    }
}


+ (NSString *)xaml_defaultContentPropertyName {
    return NSStringFromSelector(@selector(setters));
}

+ (id<XAMLConverter>)xaml_converterForTargetType {
    return [ClassConverter sharedInstance];
}

- (void)applyToObject:(NSObject *)object {
    if (self.basedOn) {
        [self.basedOn applyToObject:object];
    }
    for (XAMLStyleSetter * setter in self.setters) {
        [setter applyToObject:object];
    }
    for (XAMLDataTrigger * trigger in self.triggers) {
        [trigger applyToObject:object];
    }
}

- (void)xaml_applyResourceBindingsWithLocator:(id<XAMLResourceLocatorProtocol>)locator {
    [super xaml_applyResourceBindingsWithLocator:locator];
    for (XAMLStyleSetter * setter in self.setters) {
        [setter xaml_applyResourceBindingsWithLocator:locator];
    }
    for (XAMLDataTrigger * trigger in self.triggers) {
        [trigger xaml_applyResourceBindingsWithLocator:locator];
    }
}

@end
