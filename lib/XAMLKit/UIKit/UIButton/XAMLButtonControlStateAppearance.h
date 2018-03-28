//
//  XAMLButtonControlStateAppearance.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XAMLButtonControlStateAppearance : NSObject

@property (strong) UIImage * backgroundImage;
@property (strong) UIImage * image;
@property (copy) NSString * title;
@property (strong) UIColor * titleColor;
@property (strong) UIColor * titleShadowColor;

@end
