//
//  NSObject+XAML.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 07/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLConverter.h"

@interface NSObject (XAML)


/**
 Used to create dictionaries
 */
@property (copy) NSString * _Nullable xaml_key;


/**
 The implementation of this method internally calls xaml_classFor... with the property name supplied as part of the selector name. Overriding that method is preferred.

 @param propertyName The name of the property
 @return The base Class this property expects it's values to be
 */
+ (nullable Class)xaml_classForPropertyName:(nonnull NSString *)propertyName;


/**
 The implementation of this method internalls calls xaml_converterFor... with the property name supplied as part of the selector name. Overriding that method is preferred.

 @param propertyName The name of the property
 @return A converter for converting string literals into the kind of value the property expects
 */
+ (nullable id<XAMLConverter>)xaml_converterForPropertyName:(nonnull NSString *)propertyName;


/**
 Instructs the XAML parser to use this property by default if none is supplied

 @return The name of the default property
 */
+ (nullable NSString *)xaml_defaultContentPropertyName;


/**
 Constructs a new instance of this object using the supplied attributes. Override this method to provide special construction behaviour

 @param attributes The attributes to use for the new instance
 @return A newly created instance
 */
+ (nonnull instancetype)xaml_withAttributes:(nonnull NSDictionary<NSString *, NSObject *> *)attributes;


/**
 Constructs a new instance of this object using a string literal, or shorthand. There is no default implementation of this method, and it should be overriden by classes that want this behaviour.
 
 @param literal The literal string
 @return A newly created instance
 */
+ (nonnull instancetype)xaml_withLiteral:(nonnull NSString *)literal;


/**
 Apply the attributes dictionary to the receiver
 
 @param attributes The attributes to apply
 */
- (void)xaml_applyAttributes:(nonnull NSDictionary<NSString *, NSObject *> *)attributes;


/**
 Applies the receiver to a property on the supplied object
 
 @param propertyName The property name
 @param object The object to set the property on
 */
- (void)xaml_applyToProperty:(nonnull NSString *)propertyName ofObject:(nonnull NSObject *)object;


/**
 Initializes this object using the supplied attributes. Override this method to provide special construction behaviour

 @param attributes The attributes to use for the new instance
 @return The initialized instance
 */
- (nonnull instancetype)initWithXAMLAttributes:(nonnull NSDictionary<NSString *, NSObject *> *)attributes;


/**
 Initializes this object using a string literal, or shorthand. There is no default implementation of this method, and it should be overriden by classes that want this behaviour.

 @param literal The literal string
 @return The initialized instance
 */
- (nonnull instancetype)initWithXAMLLiteral:(nonnull NSString *)literal;

@end
