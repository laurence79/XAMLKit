//
//  UIView+Resources.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAMLResourceLocatorProtocol.h"
#import "XAMLStaticResource.h"

@interface UIView (Resources) <XAMLResourceLocatorProtocol>

@property (strong) NSDictionary<NSString *, id> * xaml_resources;

@end
