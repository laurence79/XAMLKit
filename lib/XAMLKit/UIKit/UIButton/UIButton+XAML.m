//
//  UIButton+XAML.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 11/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAML.h"
#import <objc/runtime.h>
#import "UIButton+XAML.h"
#import "UIButtonTypeConverter.h"
#import "UIControlStateConverter.h"
#import "XAMLButtonControlStateAppearance+Private.h"

@implementation UIButton (XAML)

+ (NSString *)xaml_defaultContentPropertyName {
    return @"xaml_controlStateAppearances";
}

+ (NSObject *)xaml_withAttributes:(NSDictionary<NSString *,id> *)attributes {
    
    NSMutableDictionary * dict = [attributes mutableCopy];
    UIButton * btn;
    
    NSString * type = dict[@"type"];
    if (type) {
        UIButtonTypeConverter * converter = [UIButtonTypeConverter sharedInstance];
        NSNumber * convertedType = [converter convertFromString:type];
        btn = [UIButton buttonWithType:convertedType.integerValue];
        [dict removeObjectForKey:@"type"];
    }
    else {
        btn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    
    [btn xaml_applyAttributes:dict];
    
    return btn;
}

- (NSDictionary<NSString *, XAMLButtonControlStateAppearance *> *)xaml_controlStateAppearances {
    return objc_getAssociatedObject(self, @selector(xaml_controlStateAppearances));
}

- (void)setXaml_controlStateAppearances:(NSDictionary<NSString *, XAMLButtonControlStateAppearance *> *)xaml_controlStateAppearances {
    
    if ([xaml_controlStateAppearances isKindOfClass:[XAMLButtonControlStateAppearance class]]) {
        // single item, parser didn't convert to dictionary
        XAMLButtonControlStateAppearance * appearance = (XAMLButtonControlStateAppearance *)xaml_controlStateAppearances;
        xaml_controlStateAppearances = @{appearance.xaml_key:appearance};
    }
    
    objc_setAssociatedObject(self, @selector(xaml_controlStateAppearances), xaml_controlStateAppearances, OBJC_ASSOCIATION_RETAIN);
    [self applyControlStateAppearances];
}

- (void)applyControlStateAppearances {
    NSDictionary<NSString *, XAMLButtonControlStateAppearance *> * controlStateAppearances = [self xaml_controlStateAppearances];
    UIControlStateConverter * converter = [UIControlStateConverter sharedInstance];
    
    for (NSString * key in controlStateAppearances) {
        UIControlState state = ((NSNumber *)[converter convertFromString:key]).integerValue;
        XAMLButtonControlStateAppearance * appearance = controlStateAppearances[key];
        appearance.controlState = state;
        appearance.button = self;
    }
}

@end
