//
//  UIView+XAMLBindings.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 11/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "MTKObserving.h"
#import "NSObject+XAML.h"
#import "NSObject+XAMLBindings.h"


@implementation NSObject (XAMLBindings)

- (NSObject *)xaml_bindingContext {
    return objc_getAssociatedObject(self, @selector(xaml_bindingContext));
}

- (void)setXaml_bindingContext:(NSObject *)xaml_bindingContext {
    objc_setAssociatedObject(self, @selector(xaml_bindingContext), xaml_bindingContext, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary<NSString *, XAMLBinding *> *)xaml_bindings
{
    NSMutableDictionary *bindings = objc_getAssociatedObject(self, @selector(xaml_bindings));
    if (!bindings) {
        bindings = [NSMutableDictionary new];
        objc_setAssociatedObject(self, @selector(xaml_bindings), bindings, OBJC_ASSOCIATION_RETAIN);
    }
    return bindings;
}

#pragma mark - XAMLBindableProtocol

- (void)xaml_addBindingConfiguration:(XAMLBinding *)binding forProperty:(NSString *)propertyName {
    [self xaml_bindings][propertyName] = binding;
}

- (void)xaml_applyBinding:(XAMLBinding *)binding toProperty:(NSString *)propertyName {
    NSString * rootProperty = @"xaml_bindingContext";
    NSString * bindFromKeyPath = (binding.path? [NSString stringWithFormat:@"%@.%@", rootProperty, binding.path] : rootProperty);
    
    [self observeProperty:bindFromKeyPath withBlock:^(NSObject * self, id oldValue, id newValue) {
        [self setValue:newValue forKeyPath:propertyName];
    }];
}

- (void)xaml_bindWithContext:(id)context {
    if (self.xaml_bindingContext) {
        [self xaml_unbindContext];
    }
    
    self.xaml_bindingContext = context;
    
    NSDictionary<NSString *, XAMLBinding *> * bindings = [self xaml_bindings];
    
    for (NSString * key in bindings) {
        XAMLBinding * binding = bindings[key];
        [self xaml_applyBinding:binding toProperty:key];
    }
}

- (void)xaml_unbindContext {
    [self removeAllObservations];
    self.xaml_bindingContext = nil;
}

@end
