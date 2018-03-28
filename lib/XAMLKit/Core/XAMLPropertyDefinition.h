//
//  XAMLPropertyDefinition.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#define kXAMLKeyProperty @"xaml_key"

#import <Foundation/Foundation.h>

@class XAMLObjectDefinition;

/**
 Used by the XAMLParser to construct a representation of an object graph for later construction.
 */
@interface XAMLPropertyDefinition : NSObject

/**
 The object that owns this property
 */
@property (readonly, weak) XAMLObjectDefinition * owningObject;

/**
 The name of the property
 */
@property (readonly, copy) NSString * name;

/**
 The current value of the property
 */
@property (readonly, strong) id value;


/**
 Create a new instance

 @param objectDefinition The object that will own this property
 @param propertyName THe name of the property
 @return A newly created instance
 */
- (instancetype)initWithObjectDefinition:(XAMLObjectDefinition *)objectDefinition propertyName:(NSString *)propertyName;


/**
 Add a property value. If a value already exists then the two will be combined into a new array. If the values have a xaml_key then a dictionary will be created and added to.

 @param value The value to add
 */
- (void)setOrAddValue:(id)value;


/**
 Creates an instance of the object that this property definition refers to.

 @return A constructed instance
 */
- (id)createValue;


@end
