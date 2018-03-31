//
//  UIColor+XAML.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import "UIColor+XAML.h"

@implementation UIColor (XAML)

+ (NSObject *)xaml_withAttributes:(NSDictionary<NSString *,id> *)attributes {
    
    if (attributes[@"named"]) {
        UIColor * color = [UIColor colorNamed:attributes[@"named"]];
        if (!color) {
            [NSException raise:NSGenericException format:@"There is no color named %@", attributes[@"named"]];
        }
        return color;
    }
    else if (attributes[@"hex"]) {
        NSString * literal = attributes[@"hex"];
        if ([literal length] < 9) {
            literal = [NSString stringWithFormat:@"%@ff", literal];
        }
        
        if ([literal length] == 9) {
            int red, green, blue, alpha;
            sscanf([literal UTF8String], "#%02X%02X%02X%02X", &red, &green, &blue, &alpha);
            
            return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha / 255.0];
        }
    }
    
    return [[self superclass] xaml_withAttributes:attributes];
}

+ (NSObject *)xaml_withLiteral:(NSString *)literal {
    UIColor *color = nil;
    
    if ([literal hasPrefix:@"#"]) {
        if ([literal length] < 9) {
            literal = [NSString stringWithFormat:@"%@ff", literal];
        }
        
        if ([literal length] == 9) {
            int red, green, blue, alpha;
            sscanf([literal UTF8String], "#%02X%02X%02X%02X", &red, &green, &blue, &alpha);
            
            color = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha / 255.0];
        }
    } else {
        UIImage *image = [UIImage imageNamed:literal];
        
        if (image != nil) {
            color = [UIColor colorWithPatternImage:image];
        } else {
            if (@available(iOS 11, tvOS 11, *)) {
                color = [UIColor colorNamed:literal];
            }
        }
    }
    
    return color;
}

@end
