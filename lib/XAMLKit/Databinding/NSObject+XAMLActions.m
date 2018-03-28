//
//  NSObject+XAMLActions.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAMLActions.h"
#import "NSObject+XAMLBindings.h"

@implementation NSObject (XAMLActions)

- (BOOL)xaml_sendAction:(XAMLAction *)action {
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@:", action.name]);
    if ([self respondsToSelector:sel]) {
        [self performSelector:sel withObject:action.context];
        return YES;
    }
    else if ([self.xaml_bindingContext respondsToSelector:sel]) {
        [self.xaml_bindingContext performSelector:sel withObject:action.context];
        return YES;
    }
    else {
        return NO;
    }
}

@end
