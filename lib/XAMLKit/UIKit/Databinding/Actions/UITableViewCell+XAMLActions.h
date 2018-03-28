//
//  UITableViewCell+XAMLActions.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAMLAction.h"

@interface UITableViewCell (XAMLActions)

/**
 The action to be dispatched when the user deletes the cell
 */
@property (strong) XAMLAction * xaml_deleteAction;

- (void)xaml_sendDeleteAction;

@end
