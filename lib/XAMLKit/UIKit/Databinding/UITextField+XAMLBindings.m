//
//  UITextView+XAMLBindings.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAMLBindings.h"
#import <objc/runtime.h>
#import "UITextField+XAMLBindings.h"

@implementation UITextField (XAMLBindings)

static void * kTextBindingPathKey = &kTextBindingPathKey;

- (void)xaml_applyBinding:(XAMLBinding *)binding toProperty:(NSString *)propertyName {
    [super xaml_applyBinding:binding toProperty:propertyName];
    if ([propertyName isEqualToString:@"text"] && binding.mode == XAMLBindingModeTwoWay) {
        objc_setAssociatedObject(self, kTextBindingPathKey, binding.path, OBJC_ASSOCIATION_COPY);
        [self addTarget:self action:@selector(updateText) forControlEvents:UIControlEventAllEditingEvents];
    }
}

- (void)updateText {
    NSString * bindingPath = objc_getAssociatedObject(self, kTextBindingPathKey);
    NSString * keyPath = [NSString stringWithFormat:@"xaml_bindingContext.%@", bindingPath];
    [self setValue:self.text forKeyPath:keyPath];
}

@end
