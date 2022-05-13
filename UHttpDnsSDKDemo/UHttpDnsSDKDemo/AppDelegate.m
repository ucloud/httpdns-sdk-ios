//
//  AppDelegate.m
//  UHttpDnsSDKDemo
//
//  Created by jdq on 2021/11/9.
//

#import "AppDelegate.h"
#import <UHttpDnsSDK/UHttpDnsSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [[UHttpDnsManager shared] registerAuthId:@"ae2b41d7d0ea11ecb7c20242ac110016" authSecret:@"145f9a8452514d948df922bba892dcac"];
    [[UHttpDnsManager shared] enableCacheIP:YES];
    [[UHttpDnsManager shared] consolePrintLogEnable:YES];
    
    [[UHttpDnsManager shared] enableExpiredIp:NO];

    /// 降级的host
    [[UHttpDnsManager shared] setDegradeHosts:@[
        @"qq.com"
    ]];
    
    [[UHttpDnsManager shared] preGetIPsWithDomains:@[
        [[UDNSPreResolveModel alloc] initWithDomain:@"baidu.com" type:UIPTypeV4]
    ]];
    
    NSLog(@"sdkVersion -> %@", [UHttpDnsManager sdkVersion]);
    
    return YES;
}

@end
