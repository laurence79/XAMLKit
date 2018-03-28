//
//  XAMLStyleSetter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+Resources.h"
#import "NSObject+XAML.h"
#import "XAMLStyleSetter.h"

@implementation XAMLStyleSetter

- (void)applyToObject:(NSObject *)object {
    id transformedValue = self.value;
    if ([self.value isKindOfClass:[NSString class]]) {
        NSString * stringValue = (NSString *)self.value;
        Class propertyClass = [[object class] xaml_classForPropertyName:self.keyPath];
        
        // string literal
        if (propertyClass && propertyClass != [NSString class]) {
            transformedValue = [propertyClass xaml_withLiteral:stringValue];
        }
        else
        {
            id<XAMLConverter> converter = [[object class] xaml_converterForPropertyName:self.keyPath];
            if (converter) {
                transformedValue = [converter convertFromString:stringValue];
            }
        }
    }
    
    [transformedValue xaml_applyToProperty:self.keyPath ofObject:object];
}

- (void)xaml_applyResourceBindingsWithLocator:(id<XAMLResourceLocatorProtocol>)locator {
    [super xaml_applyResourceBindingsWithLocator:locator];
    [self.value xaml_applyResourceBindingsWithLocator:locator];
}

@end
