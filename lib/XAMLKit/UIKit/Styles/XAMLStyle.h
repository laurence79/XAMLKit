//
//  XAMLStyle.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLDataTrigger.h"
#import "XAMLStyleSetter.h"

@interface XAMLStyle : NSObject

@property (strong) XAMLStyleSetter * basedOn;

@property Class targetType;

@property (strong) NSArray<XAMLStyleSetter *> * setters;
@property (strong) NSArray<XAMLDataTrigger *> * triggers;

- (void)applyToObject:(NSObject *)object;

@end
