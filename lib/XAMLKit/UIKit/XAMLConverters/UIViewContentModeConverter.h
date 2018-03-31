//
//  UIViewContentModeConverter.h
//  serveplus
//
//  Created by Laurence Hartgill on 30/03/2018.
//  Copyright © 2018 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLConverter.h"

@interface UIViewContentModeConverter : NSObject<XAMLConverter>

+ (UIViewContentModeConverter *)sharedInstance;

@end
