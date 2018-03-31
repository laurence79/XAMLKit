//
//  UIImageView+XAML.m
//  serveplus
//
//  Created by Laurence Hartgill on 30/03/2018.
//  Copyright © 2018 RIVR Systems Ltd. All rights reserved.
//

#import "UIImageView+XAML.h"

@implementation UIImageView (XAML)

+ (Class)xaml_classForImage {
    return [UIImage class];
}

+ (Class)xaml_classForHighlightedImage {
    return [UIImage class];
}

@end
