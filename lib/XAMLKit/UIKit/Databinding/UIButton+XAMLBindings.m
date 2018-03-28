//
//  UIButton+XAMLBindings.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 14/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAMLBindings.h"
#import "UIButton+XAML.h"
#import "UIButton+XAMLActions.h"
#import "UIButton+XAMLBindings.h"

@implementation UIButton (XAMLBindings)

- (void)xaml_unbindContext {
    [super xaml_unbindContext];
    
    for (XAMLButtonControlStateAppearance * appearance in [self.xaml_controlStateAppearances allValues]) {
        [appearance xaml_unbindContext];
    }
}

- (void)xaml_bindWithContext:(id)context {
    [super xaml_bindWithContext:context];
    
    for (XAMLButtonControlStateAppearance * appearance in [self.xaml_controlStateAppearances allValues]) {
        [appearance xaml_bindWithContext:context];
    }
    
    for (XAMLAction * action in self.xaml_actions) {
        [action xaml_bindWithContext:context];
    }
}

@end
