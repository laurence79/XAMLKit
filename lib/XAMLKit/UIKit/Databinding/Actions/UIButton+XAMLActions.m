//
//  UIButton+XAMLActions.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "UIButton+XAMLActions.h"
#import "UIControlEventConverter.h"
#import "XAMLAction.h"
#import "XAMLAction+UIButton.h"

@implementation UIButton (XAMLActions)

- (NSArray *)xaml_actions {
    return objc_getAssociatedObject(self, @selector(xaml_actions));
}

- (void)setXaml_actions:(NSArray *)xaml_actions {
    for (XAMLAction * action in self.xaml_actions) {
        [self removeTarget:action action:@selector(send) forControlEvents:action.controlEvents];
    }
    
    if(![xaml_actions isKindOfClass:NSArray.class]) {
        xaml_actions = @[xaml_actions];
    }
    
    objc_setAssociatedObject(self, @selector(xaml_actions), xaml_actions, OBJC_ASSOCIATION_RETAIN);
    
    for (XAMLAction * action in xaml_actions) {
        action.target = self;
        [self addTarget:action action:@selector(send) forControlEvents:action.controlEvents];
    }
}

@end
