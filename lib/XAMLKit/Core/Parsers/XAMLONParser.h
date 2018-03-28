//
//  XAMLParser.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 08/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XAMLONParser;

@protocol XAMLONParserDelegate<NSObject>

- (void)xamlONParser:(nonnull XAMLONParser *)parser didBeginElement:(nonnull NSString *)elementName;
- (void)xamlONParser:(nonnull XAMLONParser *)parser didBeginProperty:(nullable NSString *)propertyName;
- (void)xamlONParser:(nonnull XAMLONParser *)parser literalPropertyValue:(nullable NSString *)propertyValue;
- (void)xamlONParserDidEndProperty:(nonnull XAMLONParser *)parser;
- (void)xamlONParserDidEndElement:(nonnull XAMLONParser *)parser;
- (void)xamlONParser:(nonnull XAMLONParser *)parser parseErrorOccurred:(nonnull NSError *)error;

@end


/**
 A special class for parsing XAML Object Notation strings, e.g. {Binding path}
 */
@interface XAMLONParser : NSObject

- (nonnull instancetype)initWithXAMLString:(nonnull NSString *)xamlString delegate:(nonnull id<XAMLONParserDelegate>)delegate;

- (void)parse;

- (void)abortParsing;

@end
