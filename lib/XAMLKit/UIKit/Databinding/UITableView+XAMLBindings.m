//
//  UITableView+XAMLBindings.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "MTKObserving.h"
#import "NSObject+XAMLBindings.h"
#import <objc/runtime.h>
#import "UITableView+XAML.h"
#import "UITableView+XAMLBindings.h"
#import "UITableViewCell+XAMLActions.h"
#import "UIView+Flexbox.h"
#import "UIView+XAMLErrors.h"
#import "XAMLBinding.h"


@interface BoundTableViewDataSource : NSObject<UITableViewDataSource>

@property (readonly, strong) id bindingContext;
@property (readonly, copy) XAMLBinding * itemsSource;
@property (readonly, weak) UITableView * tableView;
@property (readonly, strong) NSMapTable * cells;

@end

@implementation BoundTableViewDataSource

- (instancetype)initWithTableView:(UITableView *)tableView bindingContext:(id)bindingContext itemsSource:(XAMLBinding *)itemsSource {
    self = [super init];
    if (self) {
        _bindingContext = bindingContext;
        _itemsSource = itemsSource;
        _tableView = tableView;
        _cells = [NSMapTable strongToWeakObjectsMapTable];
        
        [self observeItemsSource];
    }
    return self;
}

- (void)observeItemsSource {
    
    NSString * rootProperty = @"bindingContext";
    NSString * bindFromKeyPath = (_itemsSource.path? [NSString stringWithFormat:@"%@.%@", rootProperty, _itemsSource.path] : rootProperty);
    
    [self observeRelationship:bindFromKeyPath changeBlock:^(BoundTableViewDataSource * self, id oldValue, id newValue) {
        [self.tableView reloadData];
        
    } insertionBlock:^(BoundTableViewDataSource * self, id newValue, NSIndexSet *indexes) {
        [self.tableView insertRowsAtIndexPaths:[self indexPathsForIndexSet:indexes]
                    withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } removalBlock:^(BoundTableViewDataSource * self, id oldValue, NSIndexSet *indexes) {
        [self.tableView deleteRowsAtIndexPaths:[self indexPathsForIndexSet:indexes]
                    withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    } replacementBlock:^(BoundTableViewDataSource * self, id oldValue, id newValue, NSIndexSet *indexes) {
        [self.tableView reloadRowsAtIndexPaths:[self indexPathsForIndexSet:indexes]
                    withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
}

- (NSArray<NSIndexPath *> *)indexPathsForIndexSet:(NSIndexSet *)indexSet {
    NSMutableArray * indexPaths = [NSMutableArray new];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    return indexPaths;
}

- (NSArray *)array {
    NSString * bindFromKeyPath = [NSString stringWithFormat:@"bindingContext.%@", _itemsSource.path];
    NSArray * array = [self valueForKeyPath:bindFromKeyPath];
    return array;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [_cells objectForKey:indexPath];
    if (!cell) {
        @try {
            cell = [tableView.xaml_cellTemplate createObject];
        }
        @catch (NSException * ex) {
            NSLog(@"Error constructing cell template. %@", ex.description);
#if DEBUG
            cell = [[UITableViewCell alloc] init];
            if ([cell respondsToSelector:@selector(xaml_recoverFromXAMLError:)]) {
                [cell xaml_recoverFromXAMLError:ex.description];
                return cell;
            }
            else {
                @throw;
            }
#else
            @throw;
#endif
        }
    }
    
    id element = [self.array objectAtIndex:indexPath.row];
    [cell xaml_bindWithContext:element];
    
    // TODO: What if no css?
    [cell css_applyLayout];
    
    [_cells setObject:cell forKey:indexPath];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [_cells objectForKey:indexPath];
    [cell xaml_sendDeleteAction];
}

@end

@interface UITableView ()

@property (strong) BoundTableViewDataSource * xaml_dataSource;

@end


@implementation UITableView (XAMLBindings)

+ (Class)xaml_classForXaml_itemsSource {
    return [XAMLBinding class];
}

- (XAMLBinding *)xaml_itemsSource {
    return objc_getAssociatedObject(self, @selector(xaml_itemsSource));
}

- (void)setXaml_itemsSource:(XAMLBinding *)xaml_itemsSource {
    objc_setAssociatedObject(self, @selector(xaml_itemsSource), xaml_itemsSource, OBJC_ASSOCIATION_RETAIN);
}

- (BoundTableViewDataSource *)xaml_dataSource {
    return objc_getAssociatedObject(self, @selector(xaml_dataSource));
}

- (void)setXaml_dataSource:(BoundTableViewDataSource *)xaml_dataSource {
    objc_setAssociatedObject(self, @selector(xaml_dataSource), xaml_dataSource, OBJC_ASSOCIATION_RETAIN);
}

- (void)xaml_bindWithContext:(id)context {
    [super xaml_bindWithContext:context];
    
    self.xaml_dataSource = [[BoundTableViewDataSource alloc] initWithTableView: self bindingContext:context itemsSource:self.xaml_itemsSource];
    
    self.dataSource = self.xaml_dataSource;
}

@end
