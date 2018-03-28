//
//  XAMLAction.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XAMLAction : NSObject

/**
 The argument to send with the action.
 */
@property (strong) NSObject * context;

/**
 The name of the action
 */
@property (copy) NSString * name;

/**
 The object that will consume this action
 */
@property (weak) NSObject * target;

-(void)send;

@end
