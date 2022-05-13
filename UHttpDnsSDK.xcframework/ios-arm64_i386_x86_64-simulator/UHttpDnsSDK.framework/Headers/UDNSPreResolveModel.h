//
//  UDNSPreResolveModel.h
//  UHttpDnsSDK
//
//  Created by jdq on 2021/12/7.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UIPType) {
    UIPTypeV4 = 1,
    UIPTypeV6
};

NS_ASSUME_NONNULL_BEGIN

@interface UDNSPreResolveModel : NSObject
/// 域名
@property (nonatomic, copy) NSString *domain;
/// IP type
@property (nonatomic, assign) UIPType type;

- (instancetype)initWithDomain:(NSString *)domain type:(UIPType)type;

@end

NS_ASSUME_NONNULL_END
