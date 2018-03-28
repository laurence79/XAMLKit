//
//  UIControlStateConverter.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLConverter.h"

@interface UIControlStateConverter : NSObject<XAMLConverter>

+ (UIControlStateConverter *)sharedInstance;

@end
