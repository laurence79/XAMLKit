//
//  XAMLMacros.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLMacros.h"

NSString *_XAMLAbsoluteFilePath(const char *currentFilePath, NSString *relativeFilePath) {
    NSString *currentDirectory = [[NSString stringWithUTF8String:currentFilePath] stringByDeletingLastPathComponent];
    return [currentDirectory stringByAppendingPathComponent:relativeFilePath];
}
