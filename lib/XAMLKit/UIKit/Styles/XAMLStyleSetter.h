//
//  XAMLStyleSetter.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 18/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XAMLStyleSetter : NSObject

@property (copy) NSString * keyPath;
@property (strong) NSObject * value;

- (void)applyToObject:(NSObject *)object;

@end
