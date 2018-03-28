//
//  CSSJustifyXAMLConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "CSSJustifyXAMLConverter.h"
#import "CSSEnums.h"

@implementation CSSJustifyXAMLConverter

+ (CSSJustifyXAMLConverter *)sharedInstance {
    static CSSJustifyXAMLConverter *sharedInstance = nil;
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
                   @"center" : @(CSSJustifyCenter),
                   @"flex-end" : @(CSSJustifyFlexEnd),
                   @"flex-start" : @(CSSJustifyFlexStart),
                   @"space-around" : @(CSSJustifySpaceAround),
                   @"space-between" : @(CSSJustifySpaceBetween)
                   };
    });
    
    return lookup[value];
}

@end
