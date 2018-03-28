//
//  CSSDirectionXAMLConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "CSSDirectionXAMLConverter.h"
#import "CSSEnums.h"

@implementation CSSDirectionXAMLConverter

+ (CSSDirectionXAMLConverter *)sharedInstance {
    static CSSDirectionXAMLConverter *sharedInstance = nil;
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
                   @"ltr" : @(CSSDirectionLTR),
                   @"rtl" : @(CSSDirectionRTL),
                   @"inherit" : @(CSSDirectionInherit)
                   };
    });
    
    return lookup[value];
}

@end
