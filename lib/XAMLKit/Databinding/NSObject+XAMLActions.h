//
//  NSObject+XAMLActions.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLAction.h"

@interface NSObject (XAMLActions)

- (BOOL)xaml_sendAction:(XAMLAction *)action;

@end
