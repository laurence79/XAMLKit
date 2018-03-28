//
//  Binding.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 08/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import "NSObject+XAMLBindings.h"
#import "XAMLBinding.h"
#import "XAMLBindingModeConverter.h"

@implementation XAMLBinding

+ (id<XAMLConverter>)xaml_converterForMode {
    return [XAMLBindingModeConverter sharedInstance];
}

+ (nullable NSString *)xaml_defaultContentPropertyName {
    return @"path";
}

- (void)xaml_applyToProperty:(nonnull NSString *)propertyName ofObject:(NSObject *)object {
    if ([object.class xaml_classForPropertyName:propertyName] != [XAMLBinding class]) {
        [object xaml_addBindingConfiguration:self forProperty:propertyName];
    }
    else {
        [super xaml_applyToProperty:propertyName ofObject:object];
    }
}

@end
