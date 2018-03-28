//
//  UIView+XAML.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "UIView+XAML.h"

@implementation UIView (XAML)

+ (Class)xaml_classForBackgroundColor {
    return [UIColor class];
}

+ (Class)xaml_classForLayer {
    return [CALayer class];
}

+ (nullable NSString *)xaml_defaultContentPropertyName {
    return @"subviews";
}

- (void)setSubviews:(id _Nonnull)subviews {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if ([subviews isKindOfClass:[NSArray class]]) {
        for (UIView * subview in subviews) {
            [self addSubview:subview];
        }
    }
    else if ([subviews isKindOfClass:[UIView class]]) {
        [self addSubview:subviews];
    }
}

@end
