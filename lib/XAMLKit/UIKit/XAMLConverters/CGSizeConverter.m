//
//  CGSizeConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "CGSizeConverter.h"
#import <UIKit/UIKit.h>

@implementation CGSizeConverter

+ (CGSizeConverter *)sharedInstance {
    static CGSizeConverter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)convertFromString:(NSString *)value {
    return @(CGSizeFromString([NSString stringWithFormat:@"{%@}", value]));
}

@end
