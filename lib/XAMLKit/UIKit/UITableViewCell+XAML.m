//
//  UITableViewCell+XAML.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import "UITableViewCellStyleConverter.h"
#import "UITableViewCell+XAML.h"

@implementation UITableViewCell (XAML)

+ (NSObject *)xaml_withAttributes:(NSDictionary<NSString *,id> *)attributes {
    
    NSMutableDictionary * dict = [attributes mutableCopy];
    UITableViewCell * cell;
    
    NSString * style = attributes[@"style"];
    if (style) {
        UITableViewCellStyleConverter * converter = [UITableViewCellStyleConverter sharedInstance];
        NSNumber * convertedStyle = [converter convertFromString:style];
        cell = [[self alloc] initWithStyle:convertedStyle.intValue reuseIdentifier:nil];
        [dict removeObjectForKey:@"style"];
    }
    else {
        cell = [self new];
    }
    
    [cell xaml_applyAttributes:dict];
    
    return cell;
}

@end
