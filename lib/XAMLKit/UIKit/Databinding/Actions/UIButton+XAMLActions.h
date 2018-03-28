//
//  UIButton+XAMLActions.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAMLAction.h"

@interface UIButton (XAMLActions)

/**
 An array of actions to bind to the button's control events
 */
@property (strong) NSArray * xaml_actions;

@end
