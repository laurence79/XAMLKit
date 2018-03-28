//
//  XAMLResourceBindableProtocol.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XAMLStaticResource;
@protocol XAMLResourceLocatorProtocol;

@protocol XAMLResourceBindableProtocol <NSObject>

- (void)xaml_addResourceBinding:(XAMLStaticResource *)binding forProperty:(NSString *)propertyName;

- (void)xaml_applyResourceBindingsWithLocator:(id<XAMLResourceLocatorProtocol>)locator;

@end
