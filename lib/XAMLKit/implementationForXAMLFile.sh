#!/bin/sh

#  createClassForXAMLFile.sh
#  LHLayoutPoc
#
#  Created by Laurence Hartgill on 17/12/2017.
#  Copyright © 2017 RIVR Systems Ltd. All rights reserved.

INPUT_FILE_BASE=$1
INPUT_FILE_NAME=$2
INPUT_FILE_PATH=$3

cat << EOF
//
//  Created by implementationForXAMLFile.sh
//

#import "$INPUT_FILE_NAME.h"
#import "NSObject+XAML.h"
#import "NSObject+XAMLBindings.h"
#import "UIView+XAMLErrors.h"
#import "XAMLFileWatcher.h"
#import "XAMLObjectDefinition.h"
#import "XAMLParser.h"

@implementation $INPUT_FILE_BASE

static XAMLObjectDefinition * objectDefinition;
static NSString * parseErrorMessage;

#if DEBUG
#if TARGET_IPHONE_SIMULATOR
static NSMapTable * instanceReloadBlocks;
#endif
#endif

+ (void)initialize {
    [self reloadObjectDefinition];

#if DEBUG
#if TARGET_IPHONE_SIMULATOR
    instanceReloadBlocks = [NSMapTable weakToStrongObjectsMapTable];
    static NSString * sourceFilePath = @"$INPUT_FILE_PATH";
    [XAMLFileWatcher watchForChangesToFilePath:sourceFilePath withCallback:^{
        NSLog(@"Reloading $INPUT_FILE_PATH");
        [self reloadObjectDefinition];
        for (void (^block)(void) in [instanceReloadBlocks objectEnumerator]) {
            dispatch_async(dispatch_get_main_queue(), block);
        }
    }];
#endif
#endif
}

+ (void)reloadObjectDefinition {
    @synchronized(self) {
        XAMLParser * parser;

#if TARGET_IPHONE_SIMULATOR
        parser = [[XAMLParser alloc] initWithFilePath:@"$INPUT_FILE_PATH"];
#else
        parser = [[XAMLParser alloc] initWithName:@"$INPUT_FILE_NAME" bundle:nil];
#endif

        [parser parseWithCompletion:^(XAMLObjectDefinition *obj, NSError *error) {
            objectDefinition = obj;
            parseErrorMessage = error.localizedDescription;

            if (error) {
                NSLog(@"Error parsing XAML file $INPUT_FILE_NAME. %@", error.localizedDescription);
            }
        }];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self reloadObject];

#if DEBUG
#if TARGET_IPHONE_SIMULATOR
        __weak typeof(self) _self = self;
        [instanceReloadBlocks setObject:^{
            NSLog(@"Reloading $INPUT_FILE_BASE instance");
            [_self reloadObject];
        } forKey:_self];
#endif
#endif

    }
    return self;
}

- (void)reloadObject {
    if (parseErrorMessage) {
        if ([self respondsToSelector:@selector(xaml_recoverFromXAMLError:)]) {
            [self xaml_recoverFromXAMLError:parseErrorMessage];
        }
        else {
            [NSException raise:NSGenericException format:@"Error parsing $INPUT_FILE_NAME"];
        }
    }
    else {
        @try {
            [self xaml_applyAttributes:[objectDefinition createProperties]];
            if (self.xaml_bindingContext) {
                [self xaml_bindWithContext:self.xaml_bindingContext];
            }
        }
        @catch (NSException * ex) {
            NSLog(@"Error constructing objects from XAML in file $INPUT_FILE_NAME. %@", ex.description);
            if ([self respondsToSelector:@selector(xaml_recoverFromXAMLError:)]) {
                [self xaml_recoverFromXAMLError:ex.description];
            }
            else {
                @throw;
            }
        }
    }
}

@end

EOF


