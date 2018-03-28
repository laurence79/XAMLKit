//
//  UIView+XAMLErrorHandler.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "UIView+Flexbox.h"
#import "UIView+XAMLErrors.h"

@implementation UIView (XAMLErrors)

- (void)xaml_recoverFromXAMLError:(NSString *)errorMessage {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview:[self createDebugViewForErrorMessage:errorMessage]];
    self.css_usesFlexbox = YES;
    [self css_applyLayout];
}

- (UIView *)createDebugViewForErrorMessage:(NSString *)errorMessage {
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    view.css_usesFlexbox = YES;
    view.css_paddingAll = 20.0f;
    
    UILabel * headingLabel = [UILabel new];
    headingLabel.text = @"XAML Error";
    headingLabel.textColor = [UIColor whiteColor];
    headingLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [view addSubview:headingLabel];
    
    UILabel * bodyLabel = [UILabel new];
    bodyLabel.text = errorMessage;
    bodyLabel.textColor = [UIColor whiteColor];
    bodyLabel.numberOfLines = 0;
    [view addSubview:bodyLabel];
    
    return view;
}

@end
