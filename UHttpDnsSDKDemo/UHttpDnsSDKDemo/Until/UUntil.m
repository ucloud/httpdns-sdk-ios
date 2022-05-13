//
//  UUntil.m
//  UHttpDnsSDKDemo
//
//  Created by jdq on 2021/12/8.
//

#import "UUntil.h"

@implementation UUntil

+ (BOOL)isDomain:(NSString *)domain {
    static dispatch_once_t onceToken;
    static NSRegularExpression *regularExpression = nil;
    dispatch_once(&onceToken, ^{
        regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    if (!domain || domain.length == 0) {
        return NO;
    }
    NSTextCheckingResult *checkResult = [regularExpression firstMatchInString:domain options:0 range:NSMakeRange(0, domain.length)];
    if (checkResult.range.length == domain.length) {
        return YES;
    }
    return NO;
}

@end
