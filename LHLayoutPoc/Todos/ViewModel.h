//
//  ViewModel.h
//  InspectablePOC
//
//  Created by Laurence Hartgill on 22/11/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../lib/XAMLKit/Core/KVCMacros.h"

@interface ViewModelItem : NSObject

@property (copy) NSString * title;

@end

@interface ViewModel : NSObject

@property (copy) NSString * addTodoText;
@property bool addButtonEnabled;
@property bool menuOpen;
@property (readonly) NSArray<ViewModelItem *> * todos;

@end
