//
//  XAMLParser.m
//  LHLayoutPoc
//
//  Created by Laurence Hartgill on 08/12/2017.
//  Copyright © 2017 RIVR Systems Ltd. All rights reserved.
//

#import "XAMLErrors.h"
#import "XAMLONParser.h"

typedef enum {
    MatchTypeClassStart = 1,
    MatchTypeClassName,
    MatchTypePropertyName,
    MatchTypeEquals,
    MatchTypeComma,
    MatchTypePropertyValue,
    MatchTypeDefaultProperty,
    MatchTypeClassEnd,
    MatchTypeInvalid,
} MatchType;

const int kNumberofMatchTypes = 9;

@implementation XAMLONParser {
    BOOL _aborting;
    NSTextCheckingResult * _currentMatch;
    NSInteger _currentMatchIndex;
    MatchType _currentMatchType;
    NSInteger _currentPosition;
    NSString * _currentValue;
    id<XAMLONParserDelegate> _delegate;
    NSArray<NSTextCheckingResult *> * _matches;
    NSString * _xamlString;
}

- (instancetype)initWithXAMLString:(NSString *)xamlString delegate:(id<XAMLONParserDelegate>)delegate {
    self = [super init];
    if (self) {
        _xamlString = xamlString;
        _delegate = delegate;
    }
    return self;
}

- (void)parse {
    static NSRegularExpression * regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString * pattern = @"\
        (?:(\\{)|\
        ((?<=\\{)\\w+)|\
        (\\w+(?=\\=))|\
        (\\=)|\
        (,)|\
        ((?<=\\=)\\w+)|\
        ((?<=\\s)\\w+(?=\\s|\\}|,))|\
        (\\})|\
        (\\S{1}))";
        
        regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    });
    
    _matches = [regex matchesInString:_xamlString options:0 range:NSMakeRange(0, [_xamlString length])];
    _currentMatchIndex = -1;
    [self moveNext];
    
    BOOL waitingForClassName = NO;
    BOOL waitingForPropertyValue = NO;
    
    while(_currentMatch && !_aborting) {
        
        if (waitingForClassName && _currentMatchType != MatchTypeClassName) {
            [self endWithErrorMessage:[NSString stringWithFormat:@"Expected a class name, instead got %@", _currentValue]];
            return;
        }
        
        if (waitingForPropertyValue && (_currentMatchType == MatchTypeClassEnd || _currentMatchType == MatchTypeComma)) {
            [_delegate xamlONParserDidEndProperty:self];
            waitingForPropertyValue = NO;
        }
        
        switch(_currentMatchType) {
                
            case MatchTypeClassStart:
                waitingForClassName = YES;
                break;
            
            case MatchTypeClassName:
                [_delegate xamlONParser:self didBeginElement:_currentValue];
                waitingForClassName = NO;
                break;
            
            case MatchTypePropertyName:
                [_delegate xamlONParser:self didBeginProperty:_currentValue];
                waitingForPropertyValue = YES;
                break;
            
            case MatchTypeDefaultProperty:
                [_delegate xamlONParser:self literalPropertyValue:_currentValue];
                break;
                
            case MatchTypePropertyValue:
                [_delegate xamlONParser:self literalPropertyValue:_currentValue];
                [_delegate xamlONParserDidEndProperty:self];
                waitingForPropertyValue = NO;
                break;
            
            case MatchTypeClassEnd :
                [_delegate xamlONParserDidEndElement:self];
                break;
                
            case MatchTypeInvalid:
                [self endWithErrorMessage:[NSString stringWithFormat:@"Unexpected character %@", _currentValue]];
                return;
                
            case MatchTypeEquals :
            case MatchTypeComma :
            default : {}
        }
        
        [self moveNext];
        
    }
}

- (void)abortParsing {
    _aborting = YES;
}

- (void)moveNext {
    _currentMatchIndex ++;
    if (_currentMatchIndex < _matches.count) {
        _currentMatch = _matches[_currentMatchIndex];
        _currentPosition = [_currentMatch range].location;
        _currentValue = [_xamlString substringWithRange:[_currentMatch range]];
        
        for (int x=1; x <= kNumberofMatchTypes; x++) {
            if (NSEqualRanges([_currentMatch range], [_currentMatch rangeAtIndex:x])) {
                _currentMatchType = x;
                break;
            }
        }
    }
    else {
        _currentMatch = nil;
        _currentPosition = -1;
        _currentValue = nil;
        _currentMatchType = MatchTypeInvalid;
    }
}

- (void)endWithErrorMessage:(NSString *)errorMessage {
    
    errorMessage = [NSString stringWithFormat:@"%@, at position %lu", errorMessage, _currentPosition];
    
    NSError * error = [NSError errorWithDomain:kAppErrorDomain code:-101 userInfo:@{ NSLocalizedDescriptionKey: errorMessage }];
    
    [_delegate xamlONParser:self parseErrorOccurred:error];
}

@end
