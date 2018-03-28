//
//  UITableView+XAML.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAMLObjectDefinition.h"

@interface UITableView (XAML)

@property (strong) XAMLObjectDefinition * xaml_cellTemplate;

@end
