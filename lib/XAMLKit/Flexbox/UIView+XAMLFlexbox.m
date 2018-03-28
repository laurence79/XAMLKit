//
//  UIView+XAMLFlexbox.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "UIView+XAMLFlexbox.h"
#import "CSSAlignXAMLConverter.h"
#import "CSSDirectionXAMLConverter.h"
#import "CSSFlexDirectionXAMLConverter.h"
#import "CSSWrapXAMLConverter.h"
#import "CSSJustifyXAMLConverter.h"
#import "CSSPositionTypeXAMLConverter.h"

@implementation UIView (XAMLFlexbox)

+ (id<XAMLConverter>)xaml_converterForCss_alignContent {
    return [CSSAlignXAMLConverter sharedInstance];
}

+ (id<XAMLConverter>)xaml_converterForCss_alignItems {
    return [CSSAlignXAMLConverter sharedInstance];
}

+ (id<XAMLConverter>)xaml_converterForCss_alignSelf {
    return [CSSAlignXAMLConverter sharedInstance];
}

+ (id<XAMLConverter>)xaml_converterForCss_direction {
    return [CSSDirectionXAMLConverter sharedInstance];
}

+ (id<XAMLConverter>)xaml_converterForCss_flexDirection {
    return [CSSFlexDirectionXAMLConverter sharedInstance];
}

+ (id<XAMLConverter>)xaml_converterForCss_flexWrap {
    return [CSSWrapXAMLConverter sharedInstance];
}

+ (id<XAMLConverter>)xaml_converterForCss_justifyContent {
    return [CSSJustifyXAMLConverter sharedInstance];
}

+ (id<XAMLConverter>)xaml_converterForCss_positionType {
    return [CSSPositionTypeXAMLConverter sharedInstance];
}

@end
