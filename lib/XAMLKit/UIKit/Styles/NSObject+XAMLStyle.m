//
//  NSObject+XAMLStyle.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAMLStyle.h"
#import <objc/runtime.h>

@implementation NSObject (XAMLStyle)

- (XAMLStyle *)xaml_style {
    return objc_getAssociatedObject(self, @selector(xaml_style));
}

- (void)setXaml_style:(XAMLStyle *)xaml_style {
    objc_setAssociatedObject(self, @selector(xaml_style), xaml_style, OBJC_ASSOCIATION_RETAIN);
    
    [xaml_style applyToObject:self];
}

@end
