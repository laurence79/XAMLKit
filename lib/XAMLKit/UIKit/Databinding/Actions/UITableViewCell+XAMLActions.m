//
//  UITableViewCell+XAMLActions.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableViewCell+XAMLActions.h"

@implementation UITableViewCell (XAMLActions)

- (XAMLAction *)xaml_deleteAction {
    return objc_getAssociatedObject(self, @selector(xaml_deleteAction));
}

- (void)setXaml_deleteAction:(XAMLAction *)xaml_deleteAction {
    xaml_deleteAction.target = self;
    objc_setAssociatedObject(self, @selector(xaml_deleteAction), xaml_deleteAction, OBJC_ASSOCIATION_RETAIN);
}

- (void)xaml_sendDeleteAction {
    [self.xaml_deleteAction send];
}

@end
