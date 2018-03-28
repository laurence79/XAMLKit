//
//  XAMLObjectDefinition.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLPropertyDefinition.h"


/**
 Used by the XAMLParser to construct a representation of an object graph for later construction.
 */
@interface XAMLObjectDefinition : NSObject

/**
 The name of the class that this definition represents
 */
@property (readonly, copy) NSString * className;


/**
 Creates an instance of the object that this definition represents (including child properties)

 @return The created object
 */
- (id)createObject;


/**
 Creates the child properties of the object that this definition represents

 @return The properties dictionary
 */
- (NSMutableDictionary<NSString *, id> *)createProperties;


/**
 Returns the child property definition, creating it if it does not already exist.

 @param name The property name
 @return The child property definition
 */
- (XAMLPropertyDefinition *)getOrCreatePropertyWithName:(NSString *)name;


/**
 Checks to see if a property has been previously defined
 
 @param named The property name
 @return Whether the property exists
 */
- (BOOL)hasPropertyNamed:(NSString *)named;

/**
 Convenience method for constructing new object definitions

 @param className The name of the class that this definition will represent
 @return A new definition
 */
+ (XAMLObjectDefinition *)objectDefinitionWithClassName:(NSString *)className;

@end
