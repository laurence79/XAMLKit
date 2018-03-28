//
//  Binding.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 08/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum XAMLBindingMode {
    XAMLBindingModeOneWay,
    XAMLBindingModeTwoWay
} XAMLBindingMode;

@interface XAMLBinding : NSObject

/**
 The path on the context to bind to
 */
@property (copy) NSString * path;

/**
 The mode of the binding, one or two way
 */
@property (assign) XAMLBindingMode mode;

@end
