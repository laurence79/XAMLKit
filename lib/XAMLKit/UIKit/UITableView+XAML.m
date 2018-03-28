//
//  UITableView+XAML.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableView+XAML.h"

@implementation UITableView (XAML)

+ (nullable NSString *)xaml_defaultContentPropertyName {
    return @"xaml_cellTemplate";
}

- (XAMLObjectDefinition *)xaml_cellTemplate {
    return objc_getAssociatedObject(self, @selector(xaml_cellTemplate));
}

- (void)setXaml_cellTemplate:(XAMLObjectDefinition *)xaml_cellTemplate {
    objc_setAssociatedObject(self, @selector(xaml_cellTemplate), xaml_cellTemplate, OBJC_ASSOCIATION_RETAIN);
}

+ (Class)xaml_classForXaml_cellTemplate {
    return [XAMLObjectDefinition class];
}

@end
