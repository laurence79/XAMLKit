//
//  XAMLConverter.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Implement this protocol to provide special conversion from a string value. Recommended for use with enums.
 */
@protocol XAMLConverter <NSObject>


/**
 Converts a string value to another type of value

 @param value The value to convert
 @return The converted value
 */
- (id)convertFromString:(NSString *)value;

@end
