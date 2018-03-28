//
//  KVCMacros.h
//  InspectablePOC
//
//  Created by Laurence Hartgill on 22/11/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#ifndef KVCMacros_h
#define KVCMacros_h

#define ADD_KVC_TO_MANY_RELATIONSHIP(IVAR_NAME, PROPERTY_NAME_CAMEL_CASE, PROPERTY_NAME_INITIAL_CASE, PROPERTY_MEMBER_TYPE) \
- (NSArray<PROPERTY_MEMBER_TYPE> *)PROPERTY_NAME_CAMEL_CASE {\
    return IVAR_NAME;\
}\
\
- (NSUInteger)countOf##PROPERTY_NAME_INITIAL_CASE; {\
    return [IVAR_NAME count];\
}\
\
- (id)objectIn##PROPERTY_NAME_INITIAL_CASE##AtIndex:(NSUInteger)index { \
    return [IVAR_NAME objectAtIndex:index];\
}\
\
- (NSArray *)PROPERTY_NAME_CAMEL_CASE##AtIndexes:(NSIndexSet *)indexes { \
    return [IVAR_NAME objectsAtIndexes:indexes];\
}\
\
- (void)get##PROPERTY_NAME_INITIAL_CASE:(PROPERTY_MEMBER_TYPE __unsafe_unretained *)buffer range:(NSRange)inRange { \
    [IVAR_NAME getObjects:buffer range:inRange];\
}\
\
- (NSUInteger)indexOf##PROPERTY_NAME_INITIAL_CASE##Object:(PROPERTY_MEMBER_TYPE)obj {\
    NSInteger index = 0;\
    for (PROPERTY_MEMBER_TYPE item in IVAR_NAME) {\
        if (item == obj) {\
            return index;\
        }\
        index ++;\
    }\
    return -1;\
}\
\
- (void)insertObject:(PROPERTY_MEMBER_TYPE)PROPERTY_NAME_CAMEL_CASE in##PROPERTY_NAME_INITIAL_CASE##AtIndex:(NSUInteger)index { \
    [IVAR_NAME insertObject:PROPERTY_NAME_CAMEL_CASE atIndex:index];\
}\
\
- (void)insert##PROPERTY_NAME_INITIAL_CASE:(NSArray *)PROPERTY_NAME_CAMEL_CASE atIndexes:(NSIndexSet *)indexes { \
    [IVAR_NAME insertObjects:PROPERTY_NAME_CAMEL_CASE atIndexes:indexes];\
}\
\
- (void)removeObjectFrom##PROPERTY_NAME_INITIAL_CASE##AtIndex:(NSUInteger)index { \
    [IVAR_NAME removeObjectAtIndex:index];\
}\
\
- (void)remove##PROPERTY_NAME_INITIAL_CASE##AtIndexes:(NSIndexSet *)indexes { \
    [IVAR_NAME removeObjectsAtIndexes:indexes];\
}\
\
- (void)replaceObjectIn##PROPERTY_NAME_INITIAL_CASE##AtIndex:(NSUInteger)index withObject:(id)anObject { \
    [IVAR_NAME replaceObjectAtIndex:index withObject:anObject];\
}\
\
- (void)replace##PROPERTY_NAME_INITIAL_CASE##AtIndexes:(NSIndexSet *)indexes with##PROPERTY_NAME_INITIAL_CASE:(NSArray *)PROPERTY_NAME_CAMEL_CASE { \
    [IVAR_NAME replaceObjectsAtIndexes:indexes withObjects:PROPERTY_NAME_CAMEL_CASE];\
}\




#endif /* KVCMacros_h */
