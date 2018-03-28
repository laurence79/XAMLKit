//
//  CSSFlexDirectionXAMLConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "CSSFlexDirectionXAMLConverter.h"
#import "CSSEnums.h"

@implementation CSSFlexDirectionXAMLConverter

+ (CSSFlexDirectionXAMLConverter *)sharedInstance {
    static CSSFlexDirectionXAMLConverter *sharedInstance = nil;
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
                   @"row" : @(CSSFlexDirectionRow),
                   @"column" : @(CSSFlexDirectionColumn),
                   @"row-reverse" : @(CSSFlexDirectionRowReverse),
                   @"column-reverse" : @(CSSFlexDirectionColumnReverse),
                   };
    });
    
    return lookup[value];
}

@end
