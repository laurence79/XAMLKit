//
//  UITableViewCellStyleConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "UITableViewCellStyleConverter.h"
#import <UIKit/UIKit.h>

@implementation UITableViewCellStyleConverter

+ (UITableViewCellStyleConverter *)sharedInstance {
    static UITableViewCellStyleConverter *sharedInstance = nil;
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
                   @"default" : @(UITableViewCellStyleDefault),
                   @"subtitle" : @(UITableViewCellStyleSubtitle),
                   @"right-detail" : @(UITableViewCellStyleValue1),
                   @"left-detail" : @(UITableViewCellStyleValue2)
                   };
    });
    
    return lookup[value];
}

@end
