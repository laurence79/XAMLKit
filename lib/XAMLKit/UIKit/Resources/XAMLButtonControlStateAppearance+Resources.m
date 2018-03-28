//
//  XAMLButtonControlStateAppearance+Resources.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 14/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "XAMLButtonControlStateAppearance+Resources.h"
#import "XAMLResourceLocatorProtocol.h"
#import "XAMLStaticResource.h"

@implementation XAMLButtonControlStateAppearance (Resources) 

#pragma mark - XAMLResourceBindableProtocol

- (void)xaml_addResourceBinding:(XAMLStaticResource *)binding forProperty:(NSString *)propertyName {
    [self xaml_resourceBindings][propertyName] = binding;
}

- (void)xaml_applyResourceBindingsWithLocator:(id<XAMLResourceLocatorProtocol>)locator {
    NSMutableDictionary<NSString *, XAMLStaticResource *> * bindings = [self xaml_resourceBindings];
    for (NSString * property in bindings) {
        id resource = [locator xaml_searchForResourceWithKey:bindings[property].key];
        [self setValue:resource forKeyPath:property];
    }
}

- (NSMutableDictionary<NSString *, XAMLStaticResource *> *)xaml_resourceBindings
{
    NSMutableDictionary *bindings = objc_getAssociatedObject(self, @selector(xaml_resourceBindings));
    if (!bindings) {
        bindings = [NSMutableDictionary new];
        objc_setAssociatedObject(self, @selector(xaml_resourceBindings), bindings, OBJC_ASSOCIATION_RETAIN);
    }
    return bindings;
}

@end
