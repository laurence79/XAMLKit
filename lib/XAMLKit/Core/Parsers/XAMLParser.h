//
//  XAMLXMLParser.h
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 12/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAMLONParser.h"


/**
 An object for parsing XAML files into object graphs
 */
@interface XAMLParser : NSObject<NSXMLParserDelegate, XAMLONParserDelegate>


/**
 Instantiates a XAMLParser with an absolute path

 @param filePath The absolute path to an xml file
 @return An object ready to parse the file
 */
- (instancetype)initWithFilePath:(NSString *)filePath;


/**
 Instantiates a XAMLParser from a bundled XML file

 @param name Filename
 @param bundle Bundle
 @return An object ready to parse the file
 */
- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle;;


/**
 Parse the file

 @param error An error if one occurred.
 @return The parse result
 */
- (XAMLObjectDefinition *)parseWithError:(NSError **)error;

/**
 Parse the file

 @param completion A block to handle the parsing result
 */
- (void)parseWithCompletion:(void(^)(XAMLObjectDefinition * obj, NSError * error))completion;

@end
