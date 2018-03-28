//
//  CSSPositionTypeXAMLConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 08/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "CSSPositionTypeXAMLConverter.h"
#import "CSSEnums.h"

@implementation CSSPositionTypeXAMLConverter

+ (CSSPositionTypeXAMLConverter *)sharedInstance {
    static CSSPositionTypeXAMLConverter *sharedInstance = nil;
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
                   @"absolute" : @(CSSPositionTypeAbsolute),
                   @"relative" : @(CSSPositionTypeRelative)
                   };
    });
    
    return lookup[value];
}

@end
