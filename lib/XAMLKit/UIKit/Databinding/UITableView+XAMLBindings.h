//
//  UITableView+XAMLBindings.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAMLAction.h"
#import "XAMLBinding.h"

@interface UITableView (XAMLBindings)

/**
 The array to bind the tableview to
 */
@property (copy) XAMLBinding * xaml_itemsSource;

@end
