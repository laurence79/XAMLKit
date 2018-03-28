//
//  XAMLAction.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import "NSObject+XAMLActions.h"
#import <UIKit/UIKit.h>
#import "XAMLAction.h"

@implementation XAMLAction

+ (nullable NSString *)xaml_defaultContentPropertyName {
    return @"name";
}

- (void)send {
    if (![self.target xaml_sendAction:self]) {
        [NSException raise:NSGenericException format:@"Nothing handled action %@", self.name];
    }
}

@end
