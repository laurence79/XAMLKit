//
//  UIView+XAMLBindings.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 14/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAMLBindings.h"
#import "Swizzling.h"
#import "UIView+XAMLBindings.h"

@implementation UIView (XAMLBindings)

- (void)xaml_unbindContext {
    [super xaml_unbindContext];
    
    for (UIView * subView in self.subviews) {
        [subView xaml_unbindContext];
    }
}

- (void)xaml_bindWithContext:(id)context {
    [super xaml_bindWithContext:context];
    
    for (UIView * subview in self.subviews) {
        [subview xaml_bindWithContext:context];
    }
}

@end
