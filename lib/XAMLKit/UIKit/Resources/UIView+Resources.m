//
//  UIView+Resources.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import "NSObject+Resources.h"
#import <objc/runtime.h>
#import "Swizzling.h"
#import "UIView+Resources.h"
#import "XAMLStaticResource.h"

@implementation UIView (Resources)

+ (void)load
{
    MethodSwizzle(self, @selector(addSubview:), @selector(override_addSubview:));
}

- (void)override_addSubview:(UIView *)view {
    // swizzled
    [self override_addSubview:view];
    
    [self xaml_applyResourceBindingsWithLocator:self];
}

- (void)xaml_applyResourceBindingsWithLocator:(id<XAMLResourceLocatorProtocol>)locator {
    [super xaml_applyResourceBindingsWithLocator:locator];
    for (UIView * subview in self.subviews) {
        [subview xaml_applyResourceBindingsWithLocator:subview];
    }
    for (NSObject * resource in self.xaml_resources) {
        [resource xaml_applyResourceBindingsWithLocator:self];
    }
}


#pragma mark - XAMLResourceLocatorProtocol

- (id)xaml_searchForResourceWithKey:(NSString *)key {
    id localResource = self.xaml_resources[key];
    if (localResource) {
        return localResource;
    }
    else if (self.superview) {
        return [self.superview xaml_searchForResourceWithKey:key];
    }
    else if (self.window) {
        return [self.window xaml_searchForResourceWithKey:key];
    }
    else {
        NSLog(@"Resource with key %@ could not be located", key);
        return nil;
    }
}

- (NSDictionary<NSString *, id> *)xaml_resources {
    return objc_getAssociatedObject(self, @selector(xaml_resources));
}

- (void)setXaml_resources:(NSDictionary<NSString *, id> *)xaml_resources {
    objc_setAssociatedObject(self, @selector(xaml_resources), xaml_resources, OBJC_ASSOCIATION_RETAIN);
    [self xaml_applyResourceBindingsWithLocator:self];
}

@end
