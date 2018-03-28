//
//  UIButton+XAML.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 11/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAMLButtonControlStateAppearance.h"

@interface UIButton (XAML)

@property (strong) NSDictionary<NSString *, XAMLButtonControlStateAppearance *> * xaml_controlStateAppearances;

@end
