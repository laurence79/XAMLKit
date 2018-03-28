//
//  UITableViewCellStyleConverter.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLConverter.h"

@interface UITableViewCellStyleConverter : NSObject<XAMLConverter>

+ (UITableViewCellStyleConverter *)sharedInstance;

@end
