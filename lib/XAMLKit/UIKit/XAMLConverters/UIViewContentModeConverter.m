//
//  UIViewContentModeConverter.m
//  serveplus
//
//  Created by Laurence Hartgill on 30/03/2018.
//  Copyright © 2018 RIVR Systems Ltd. All rights reserved.
//

#import "UIViewContentModeConverter.h"

@implementation UIViewContentModeConverter

+ (UIViewContentModeConverter *)sharedInstance {
    static UIViewContentModeConverter *sharedInstance = nil;
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
                   @"scale-to-fill" : @(UIViewContentModeScaleToFill),
                   @"scale-aspect-fit" : @(UIViewContentModeScaleAspectFit),
                   @"scale-aspect-fill" : @(UIViewContentModeScaleAspectFill),
                   @"redraw" : @(UIViewContentModeRedraw),
                   @"center" : @(UIViewContentModeCenter),
                   @"top" : @(UIViewContentModeTop),
                   @"bottom" : @(UIViewContentModeBottom),
                   @"left" : @(UIViewContentModeLeft),
                   @"right" : @(UIViewContentModeRight),
                   @"top-left" : @(UIViewContentModeTopLeft),
                   @"top-right" : @(UIViewContentModeTopRight),
                   @"bottom-left" : @(UIViewContentModeBottomLeft),
                   @"bottom-right" : @(UIViewContentModeBottomRight)
                   };
    });
    
    return lookup[value];
}

@end
