//
//  XAMLDataTrigger.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLBinding.h"
#import "XAMLStyleSetter.h"

@interface XAMLDataTrigger : NSObject

@property (strong) XAMLBinding * binding;
@property (strong) NSArray<XAMLStyleSetter *> * setters;
@property (strong) NSObject * value;

- (void)applyToObject:(NSObject *)object;

@end
