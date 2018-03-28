//
//  XAMLStaticResource.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+Resources.h"
#import "NSObject+XAML.h"
#import <UIKit/UIKit.h>
#import "XAMLStaticResource.h"

@implementation XAMLStaticResource

+ (nullable NSString *)xaml_defaultContentPropertyName {
    return @"key";
}

- (void)xaml_applyToProperty:(nonnull NSString *)propertyName ofObject:(NSObject *)object {
    NSParameterAssert(self.key);
    if ([object conformsToProtocol:@protocol(XAMLResourceBindableProtocol)] && [object.class xaml_classForPropertyName:propertyName] != [XAMLStaticResource class]) {
        [(id<XAMLResourceBindableProtocol>)object xaml_addResourceBinding:self forProperty:propertyName];
    }
    else {
        [super xaml_applyToProperty:propertyName ofObject:object];
    }
}

@end
