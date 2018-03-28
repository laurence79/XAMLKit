//
//  Swizzling.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 14/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

void MethodSwizzle(Class c, SEL origSEL, SEL overrideSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod = class_getInstanceMethod(c, overrideSEL);
    
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)))
    {
        class_replaceMethod(c, overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
