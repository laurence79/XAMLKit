//
//  XAMLButtonControlStateAppearance.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import "XAMLButtonControlStateAppearance.h"

@interface XAMLButtonControlStateAppearance ()

@property (assign) UIButton * button;
@property UIControlState controlState;

@end

@implementation XAMLButtonControlStateAppearance {
    UIImage * _backgroundImage;
    __unsafe_unretained UIButton * _button;
    UIControlState _controlState;
    UIImage * _image;
    NSString * _title;
    UIColor * _titleColor;
    UIColor * _titleShadowColor;
}

+ (Class)xaml_classForBackgroundImage {
    return [UIImage class];
}

+ (Class)xaml_classForImage {
    return [UIImage class];
}

+ (Class)xaml_classForTitleColor {
    return [UIColor class];
}

+ (Class)xaml_classForTitleShadowColor {
    return [UIColor class];
}

- (UIImage *)backgroundImage {
    return _backgroundImage;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    if (_button) {
        [_button setBackgroundImage:backgroundImage forState:_controlState];
    }
}

- (UIButton *)button {
    return _button;
}

- (void)setButton:(UIButton *)button {
    _button = button;
    if (_button) {
        [_button setBackgroundImage:_backgroundImage forState:_controlState];
        [_button setImage:_image forState:_controlState];
        [_button setTitle:_title forState:_controlState];
        [_button setTitleColor:_titleColor forState:_controlState];
        [_button setTitleShadowColor:_titleShadowColor forState:_controlState];
    }
}

- (UIImage *)image {
    return _image;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    if (_button) {
        [_button setImage:image forState:_controlState];
    }
}

- (NSString *)title {
    return _title;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_button) {
        [_button setTitle:title forState:_controlState];
    }
}

- (UIColor *)titleColor {
    return _titleColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    if (_button) {
        [_button setTitleColor:titleColor forState:_controlState];
    }
}

- (UIColor *)titleShadowColor {
    return _titleShadowColor;
}

- (void)setTitleShadowColor:(UIColor *)titleShadowColor {
    _titleShadowColor = titleShadowColor;
    if (_button) {
        [_button setTitleShadowColor:titleShadowColor forState:_controlState];
    }
}

@end
