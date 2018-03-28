//
//  UIView+XAMLActions.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAMLActions.h"
#import "UIView+XAMLActions.h"

@implementation UIView (XAMLActions)

- (BOOL)xaml_sendAction:(XAMLAction *)action {
    if ([super xaml_sendAction:action]) {
        return YES;
    }
    else if (self.superview) {
        return [self.superview xaml_sendAction:action];
    }
    else {
        return NO;
    }
}

@end
