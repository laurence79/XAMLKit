//
//  CALayer+XAML.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "CALayer+XAML.h"
#import "CGSizeConverter.h"
#import "NSObject+XAML.h"
#import <UIKit/UIKit.h>

@implementation CALayer (XAML)

+ (Class)xaml_classForShadowColor {
    return [UIColor class];
}

+ (id<XAMLConverter>)xaml_converterForShadowOffset {
    return [CGSizeConverter sharedInstance];
}

@end
