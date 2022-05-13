//
//  UUntil.h
//  UHttpDnsSDKDemo
//
//  Created by jdq on 2021/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UUntil : NSObject

/**
 *  @abstract 是否是域名
 *
 *  @param domain 域名
 */
+ (BOOL)isDomain:(NSString *)domain;

@end

NS_ASSUME_NONNULL_END
