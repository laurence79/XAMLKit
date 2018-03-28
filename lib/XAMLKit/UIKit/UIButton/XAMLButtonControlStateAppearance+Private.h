//
//  XAMLButtonControlStateAppearance+Private.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 14/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "XAMLButtonControlStateAppearance.h"


/**
 IMPORTANT: Control state must be set first
 */
@interface XAMLButtonControlStateAppearance (Private)

@property (assign) UIButton * button;
@property UIControlState controlState;

@end
