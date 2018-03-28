//
//  BindingHostProtocol.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLBinding.h"

@protocol XAMLBindableProtocol <NSObject>

/**
 Records the binding intention, ready for when the data context is set

 @param binding The binding configuration
 @param propertyName The property to be bound
 */
- (void)xaml_addBindingConfiguration:(XAMLBinding *)binding forProperty:(NSString *)propertyName;

/**
 Once the datacontext has been set, this method will be called to apply the binding

 @param binding The binding configuration
 @param propertyName The property to be bound
 */
- (void)xaml_applyBinding:(XAMLBinding *)binding toProperty:(NSString *)propertyName;

- (void)xaml_bindWithContext:(id)context;

- (void)xaml_unbindContext;

@end
