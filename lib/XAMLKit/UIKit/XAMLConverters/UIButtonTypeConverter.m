//
//  UIButtonTypeConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 11/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "UIButtonTypeConverter.h"
#import <UIKit/UIKit.h>

@implementation UIButtonTypeConverter

+ (UIButtonTypeConverter *)sharedInstance {
    static UIButtonTypeConverter *sharedInstance = nil;
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
                   @"custom" : @(UIButtonTypeCustom),
                   @"system" : @(UIButtonTypeSystem),
                   @"info-dark" : @(UIButtonTypeInfoDark),
                   @"info-light" : @(UIButtonTypeInfoLight),
                   @"contact-add" : @(UIButtonTypeContactAdd),
                   @"detail-disclosure" : @(UIButtonTypeDetailDisclosure),
                   @"rounded-rect" : @(UIButtonTypeRoundedRect)
                   };
    });
    
    return lookup[value];
}

@end
