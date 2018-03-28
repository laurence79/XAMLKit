//
//  CSSAlignXAMLConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "CSSAlignXAMLConverter.h"
#import "CSSEnums.h"

@implementation CSSAlignXAMLConverter

+ (CSSAlignXAMLConverter *)sharedInstance {
    static CSSAlignXAMLConverter *sharedInstance = nil;
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
                   @"auto" : @(CSSAlignAuto),
                   @"center" : @(CSSAlignCenter),
                   @"flex-end" : @(CSSAlignFlexEnd),
                   @"flex-start" : @(CSSAlignFlexStart),
                   @"stretch" : @(CSSAlignStretch)
                   };
    });
    
    return lookup[value];
}

@end
