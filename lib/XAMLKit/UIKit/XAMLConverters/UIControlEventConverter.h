//
//  UIControlEventConverter.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLConverter.h"

@interface UIControlEventConverter : NSObject<XAMLConverter>

+ (UIControlEventConverter *)sharedInstance;

@end
