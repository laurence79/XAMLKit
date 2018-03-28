//
//  UITableViewCell+XAMLBindings.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "NSObject+XAMLBindings.h"
#import "UITableViewCell+XAMLActions.h"
#import "UITableViewCell+XAMLBindings.h"

@implementation UITableViewCell (XAMLBindings)

- (void)xaml_bindWithContext:(id)context {
    [super xaml_bindWithContext:context];
    
    if (self.xaml_deleteAction) {
        [self.xaml_deleteAction xaml_bindWithContext:context];
    }
}

@end
