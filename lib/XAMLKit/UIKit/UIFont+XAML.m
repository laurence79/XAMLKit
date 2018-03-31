//
//  UIFont+XAML.m
//  serveplus
//
//  Created by Laurence Hartgill on 30/03/2018.
//  Copyright © 2018 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import "UIFont+XAML.h"

@implementation UIFont (XAML)

+ (NSObject *)xaml_withAttributes:(NSDictionary<NSString *,id> *)attributes {
    
    NSString * fontName = attributes[@"name"];
    NSString * fontSizeStr = attributes[@"size"];
    
    if (fontName && fontSizeStr) {
        CGFloat fontSize = [fontSizeStr floatValue];
        return [UIFont fontWithName:fontName size:fontSize];
    }
    
    if (fontSizeStr) {
        CGFloat fontSize = [fontSizeStr floatValue];
        return [UIFont systemFontOfSize:fontSize];
    }
    
    return [[self superclass] xaml_withAttributes:attributes];
}

@end