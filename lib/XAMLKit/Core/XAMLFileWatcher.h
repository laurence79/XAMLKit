//
//  XAMLFileWatcher.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 15/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XAMLFileWatcher : NSObject

+ (dispatch_source_t)watchForChangesToFilePath:(NSString *)filePath withCallback:(dispatch_block_t)callback;

@end
