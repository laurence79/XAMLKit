//
//  UIView+XAMLErrorHandler.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XAMLErrors)

- (void)xaml_recoverFromXAMLError:(NSString *)errorMessage;

@end
