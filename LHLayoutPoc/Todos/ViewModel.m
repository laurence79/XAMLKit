//
//  ViewModel.m
//  InspectablePOC
//
//  Created by Laurence Hartgill on 22/11/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "../../lib/XAMLKit/Core/EXTKeyPathCoding.h"
#import "MTKObserving.h"
#import "ViewModel.h"

@implementation ViewModelItem

@end


@implementation ViewModel {
    NSMutableArray * _items;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray new];
        
        [self observeProperty:@keypath(self.addTodoText) withBlock:^(ViewModel * self, id oldValue, NSString * newValue) {
            self.addButtonEnabled = (newValue && newValue.length > 0);
        }];
    }
    return self;
}

- (void)addTodo:(id)context {
    ViewModelItem * item = [ViewModelItem new];
    item.title = self.addTodoText;
    
    [self insertObject:item inItemsAtIndex:self.countOfItems];
    
    self.addTodoText = @"";
}

- (void)deleteTodo:(id)context {
    ViewModelItem * item = (ViewModelItem *)context;
    NSInteger index = [self indexOfItemsObject:item];
    if (index > -1) {
        [self removeObjectFromItemsAtIndex:index];
    }
}

- (void)toggleMenu:(id)context {
    self.menuOpen = !self.menuOpen;
}

ADD_KVC_TO_MANY_RELATIONSHIP(_items, items, Items, ViewModelItem *)

@end
