//
//  XAMLMacros.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

// Path resolution
#define XAMLAbsoluteFilePath(relativePath) \
_XAMLAbsoluteFilePath(__FILE__, relativePath)
NSString *_XAMLAbsoluteFilePath(const char *currentFilePath, NSString *relativeFilePath);

