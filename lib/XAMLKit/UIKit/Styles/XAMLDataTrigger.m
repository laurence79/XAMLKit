//
//  XAMLDataTrigger.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "MTKObserving.h"
#import "NSObject+XAML.h"
#import "XAMLDataTrigger.h"
#import <UIKit/UIKit.h>
#import "UIView+Flexbox.h"

@implementation XAMLDataTrigger {
    NSArray<XAMLStyleSetter *> * _setters;
}

- (NSArray<XAMLStyleSetter *> *)setters {
    return _setters;
}

- (void)setSetters:(NSArray<XAMLStyleSetter *> *)setters {
    if (![setters isKindOfClass:[NSArray class]]) {
        _setters = @[(XAMLStyleSetter *)setters];
    }
    else {
        _setters = setters;
    }
}

+ (Class)xaml_classForBinding {
    return [XAMLBinding class];
}

+ (NSString *)xaml_defaultContentPropertyName {
    return NSStringFromSelector(@selector(setters));
}

- (void)applyToObject:(NSObject *)object {
    NSString * rootProperty = @"xaml_bindingContext";
    NSString * bindFromKeyPath = (self.binding.path? [NSString stringWithFormat:@"%@.%@", rootProperty, self.binding.path] : rootProperty);
    
    [self observeObject:object property:bindFromKeyPath withBlock:^(XAMLDataTrigger * self, id object, id oldValue, id newValue) {
        
        if (newValue == self.value) {
            for (XAMLStyleSetter * setter in self.setters) {
                [setter applyToObject:object];
            }
            if ([object isKindOfClass:[UIView class]]) {
                UIView * view = (UIView *)object;
                if (view.css_usesFlexbox) {
                    [view css_applyLayout];
                }
                
            }
        }
    }];
}

@end
