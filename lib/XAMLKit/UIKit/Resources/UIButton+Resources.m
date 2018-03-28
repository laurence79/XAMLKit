//
//  UIButton+Resources.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 14/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+Resources.h"
#import "UIButton+Resources.h"
#import "UIButton+XAML.h"
#import "UIView+Resources.h"
#import "XAMLButtonControlStateAppearance+Resources.h"

@implementation UIButton (Resources)

- (void)xaml_applyResourceBindingsWithLocator:(id<XAMLResourceLocatorProtocol>)locator {
    [super xaml_applyResourceBindingsWithLocator:locator];
    
    for (XAMLButtonControlStateAppearance * appearance in [self.xaml_controlStateAppearances allValues]) {
        [appearance xaml_applyResourceBindingsWithLocator:locator];
    }
}

@end
