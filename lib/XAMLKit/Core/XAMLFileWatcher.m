//
//  XAMLFileWatcher.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 15/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "XAMLFileWatcher.h"

@implementation XAMLFileWatcher

+ (dispatch_source_t)watchForChangesToFilePath:(NSString *)filePath withCallback:(dispatch_block_t)callback {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    int fileDescriptor = open([filePath UTF8String], O_EVTONLY);
    
    NSAssert(fileDescriptor > 0, @"Error could subscribe to events for file at path: %@", filePath);
    
    __block dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, fileDescriptor,
                                                              DISPATCH_VNODE_DELETE | DISPATCH_VNODE_WRITE | DISPATCH_VNODE_EXTEND,
                                                              queue);
    dispatch_source_set_event_handler(source, ^{
        unsigned long flags = dispatch_source_get_data(source);
        if (flags) {
            dispatch_source_cancel(source);
            callback();
            [self watchForChangesToFilePath:filePath withCallback:callback];
        }
    });
    dispatch_source_set_cancel_handler(source, ^(void){
        close(fileDescriptor);
    });
    dispatch_resume(source);
    return source;
}

@end
