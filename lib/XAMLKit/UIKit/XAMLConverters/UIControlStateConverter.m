//
//  UIControlStateConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "UIControlStateConverter.h"
#import <UIKit/UIKit.h>

@implementation UIControlStateConverter

+ (UIControlStateConverter *)sharedInstance {
    static UIControlStateConverter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)convertFromString:(NSString *)value {
    static NSDictionary* lookup = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lookup = @{
                   @"normal" : @(UIControlStateNormal),
                   @"focused" : @(UIControlStateFocused),
                   @"disabled" : @(UIControlStateDisabled),
                   @"reserved" : @(UIControlStateReserved),
                   @"application" : @(UIControlStateApplication),
                   @"highlighted" : @(UIControlStateHighlighted)
                   };
    });
    
    return lookup[value];
}

@end
