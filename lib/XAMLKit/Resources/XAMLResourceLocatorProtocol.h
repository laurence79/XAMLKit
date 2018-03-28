//
//  XAMLResourceSourceProtocol.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 13/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XAMLResourceLocatorProtocol <NSObject>

- (id)xaml_searchForResourceWithKey:(NSString *)key ;

@end
