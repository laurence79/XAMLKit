//
//  UIImageView+XAML.m
//  serveplus
//
//  Created by Laurence Hartgill on 30/03/2018.
//  Copyright © 2018 RIVR Systems Ltd. All rights reserved.
//

#import "UIImage+XAML.h"

@implementation UIImage (XAML)

+ (NSObject *)xaml_withAttributes:(NSDictionary<NSString *,id> *)attributes {
    if (attributes[@"named"]) {
        UIImage * image = [UIImage imageNamed:attributes[@"named"]];
        if (!image) {
            [NSException raise:NSGenericException format:@"There is no image named %@", attributes[@"named"]];
        }
        return image;
    }
    
    return [[self superclass] xaml_withAttributes:attributes];
}

+ (NSObject *)xaml_withLiteral:(NSString *)literal {
    
    UIImage *image = [UIImage imageNamed:literal];
        
    if (!image) {
        [NSException raise:NSGenericException format:@"There is no image named %@", literal];
    }
    
    return image;
}

@end
