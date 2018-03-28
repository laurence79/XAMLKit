//
//  CSSWrapXAMLConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 08/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "CSSWrapXAMLConverter.h"
#import "CSSEnums.h"

@implementation CSSWrapXAMLConverter

+ (CSSWrapXAMLConverter *)sharedInstance {
    static CSSWrapXAMLConverter *sharedInstance = nil;
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
                   @"wrap" : @(CSSWrapWrap),
                   @"no-wrap" : @(CSSWrapNoWrap)
                   };
    });
    
    return lookup[value];
}

@end
