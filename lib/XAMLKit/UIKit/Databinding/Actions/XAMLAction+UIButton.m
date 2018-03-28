//
//  XAMLAction+UIButton.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "UIControlEventConverter.h"
#import "XAMLAction+UIButton.h"

@implementation XAMLAction (UIButton)

- (UIControlEvents)controlEvents {
    return ((NSNumber *)objc_getAssociatedObject(self, @selector(controlEvents))).integerValue;
}

- (void)setControlEvents:(UIControlEvents)controlEvents {
    objc_setAssociatedObject(self, @selector(controlEvents), @(controlEvents), OBJC_ASSOCIATION_RETAIN);
}

+ (id<XAMLConverter>)xaml_converterForControlEvents {
    return [UIControlEventConverter sharedInstance];
}

@end
