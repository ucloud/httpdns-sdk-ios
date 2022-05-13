//
//  UHttpDnsManager.h
//  UHttpdnsSDK
//
//  Created by jdq on 2021/11/8.
//

#import <Foundation/Foundation.h>
#import <UHttpDnsSDK/UDNSPreResolveModel.h>

typedef NS_ENUM(NSInteger, UDNSErrorCode) {
    /// 网络不可用
    UDNSErrorCodeNetworkAvailable = 0,
    /// 无效的域名格式
    UDNSErrorCodeDomainInvalid,
    /// 降级的host
    UDNSErrorCodeDegradeHost,
    /// 服务不可用
    UDNSErrorCodeServiceUnAvailable
};

typedef void(^ReturnBlock)(NSError * _Nullable error, NSArray * _Nullable ipsArray);

NS_ASSUME_NONNULL_BEGIN

@interface UHttpDnsManager : NSObject

/**
 *  @abstract 需要降级的hosts
 */
@property (nonatomic, copy) NSArray <NSString *>*degradeHosts;

/**
 *  @abstract 网络请求超时时间（默认：20s，单位：秒）
 */
@property (nonatomic, assign) NSTimeInterval timeout;

/**
 *  @abstract 单例
 *
 *  @return 返回UHttpdnsManager对象
 */
+ (instancetype)shared;

/**
 *  @abstract 自定义服务器地址（不设置，默认UCloud平台地址）
 *
 *  @param url  自定义服务器地址
 */
- (void)customServerUrl:(NSString *)url;

/**
 *  @abstract 注册应用
 *
 *  @param authId  UCloud平台申请创建应用ID
 *  @param authSecret  UCloud平台申请创建应用Secret
 */
- (void)registerAuthId:(NSString *)authId authSecret:(NSString *)authSecret;

/**
 *  @abstract 获取域名解析IP（IPv4）
 *
 *  @param domain  需要解析的域名
 */
- (void)getIPV4ByDomain:(NSString *)domain returnBlock:(ReturnBlock)handler;

/**
 *  @abstract 获取域名解析IP（IPv6）
 *
 *  @param domain  需要解析的域名
 */
- (void)getIPV6ByDomain:(NSString *)domain returnBlcok:(ReturnBlock)handler;

/**
 *  @abstract 域名预解析（注意：只有开启域名缓存时，才有效）
 *
 *  @param domains  需要解析的域名
 */
- (void)preGetIPsWithDomains:(NSArray <UDNSPreResolveModel *> *)domains;

/**
 *  @abstract 是否允许缓存IP（开启后，域名解析时返回缓存命中的值）
 *
 *  @param enable  开关
 */
- (void)enableCacheIP:(BOOL)enable;

/**
 *  @abstract 是否允许返回过期IP
 *
 *  @param enable  开关
 */
- (void)enableExpiredIp:(BOOL)enable;

/**
 *  @abstract 清除所有缓存
 */
- (void)cleanAllCache;

/**
 *  @abstract 控制台输出日志开关
 *
 *  @param enable  日志输出开关
 */
- (void)consolePrintLogEnable:(BOOL)enable;

/**
 *  @abstract SDK版本
 */
+ (NSString *)sdkVersion;

@end

NS_ASSUME_NONNULL_END
