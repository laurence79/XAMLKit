//
//  UIControlEventConverter.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 17/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "UIControlEventConverter.h"
#import <UIKit/UIKit.h>

@implementation UIControlEventConverter

+ (UIControlEventConverter *)sharedInstance {
    static UIControlEventConverter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)convertFromString:(NSString *)value {
    static NSDictionary* lookup = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lookup = @{
                   @"touchDown" : @(UIControlEventTouchDown),
                   @"touchDownRepeat" : @(UIControlEventTouchDownRepeat),
                   @"touchDragInside" : @(UIControlEventTouchDragInside),
                   @"touchDragOutside" : @(UIControlEventTouchDragOutside),
                   @"touchDragEnter" : @(UIControlEventTouchDragEnter),
                   @"touchDragExit" : @(UIControlEventTouchDragExit),
                   @"touchUpInside" : @(UIControlEventTouchUpInside),
                   @"touchUpOutside" : @(UIControlEventTouchUpOutside),
                   @"touchCancel" : @(UIControlEventTouchCancel),
                   @"valueChanged" : @(UIControlEventValueChanged),
                   @"primaryActionTriggered" : @(UIControlEventPrimaryActionTriggered),
                   @"editingDidBegin" : @(UIControlEventEditingDidBegin),
                   @"editingChanged" : @(UIControlEventEditingChanged),
                   @"editingDidEnd" : @(UIControlEventEditingDidEnd),
                   @"editingDidEndOnExit" : @(UIControlEventEditingDidEndOnExit),
                   @"allTouchEvents" : @(UIControlEventAllTouchEvents),
                   @"allEditingEvents" : @(UIControlEventAllEditingEvents),
                   @"applicationReserved" : @(UIControlEventApplicationReserved),
                   @"systemReserved" : @(UIControlEventSystemReserved),
                   @"allEvents" : @(UIControlEventAllEvents)
                   };
    });
    
    return lookup[value];
}

@end
