//
//  NSNumber+XAML.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSNumber+XAML.h"
#import "NSObject+XAML.h"

@implementation NSNumber (XAML)

+ (instancetype)xaml_withAttributes:(NSDictionary<NSString *,NSObject *> *)attributes {
    if (attributes[@"bool"] && [attributes[@"bool"] isKindOfClass:[NSString class]]) {
        if ([(NSString *)attributes[@"bool"] isEqualToString:@"YES"]) {
            return [NSNumber numberWithBool:YES];
        }
        return [NSNumber numberWithBool:NO];
    }
    return nil;
}

@end
