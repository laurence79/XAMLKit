//
//  TodosViewController.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 06/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "TodosView.xaml.h"
#import "TodosViewController.h"
#import "UIView+Flexbox.h"
#import "NSObject+XAMLBindings.h"
#import "ViewModel.h"

@interface TodosViewController ()

@end

@implementation TodosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [TodosView new];
    [self.view xaml_bindWithContext:[[ViewModel alloc] init]];
    
}

- (void)viewWillLayoutSubviews {
    // TODO: Improve this
    if (self.view.css_usesFlexbox) {
        [self.view css_applyLayout];
    }
}

@end
