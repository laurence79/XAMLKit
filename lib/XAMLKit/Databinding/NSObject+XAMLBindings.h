//
//  UIView+XAMLBindings.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 11/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "XAMLBinding.h"
#import "XAMLBindableProtocol.h"
#import <Foundation/Foundation.h>

@interface NSObject (XAMLBindings) <XAMLBindableProtocol>

@property (readonly) NSObject * xaml_bindingContext;

@end
