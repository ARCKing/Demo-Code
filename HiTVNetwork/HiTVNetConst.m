//
//  HiTVNetConst.m
//  hitv
//
//  Created by Ningmeng on 2016/10/8.
//  Copyright © 2016年 Zapper. All rights reserved.
//

#import "HiTVNetConst.h"
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

/*! @abstract -999: The request has been canceled. */
NSInteger const kHiTVNetErrorRequestCanceled = -999;

/*! @abstract -1001: The request timed out on the server. */
NSInteger const kHiTVNetErrorRequestTimeout = -1001;

/*! @abstract -1009: The Internet connection appears to be offline. */
NSInteger const kHiTVNetErrorRequestInternetOffline = -1009;

/*! @abstract -4000: Something unknow error occured, use the common error code instead. */
NSInteger const kHiTVNetErrorCommon = -4000;

/*! The common error domain for HiTV net. */
NSErrorDomain const HiTVNetCommonErrorDomain = @"com.lxsky.hitv.net.common.error";

@implementation HiTVNetConst

/**
 获取设备类型
 
 @return 设备类型
 */
+ (NSString *)DeviceType
{
    static NSString *deviceType;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *deviceMode = [UIDevice currentDevice].model;
        if ([deviceMode isEqualToString:@"iPhone"] || [deviceMode isEqualToString:@"iPhone Simulator"]) {
            deviceType = [@"iphone" copy];
        }
        else if ([deviceMode isEqualToString:@"iPad"] || [deviceMode isEqualToString:@"iPad Simulator"]) {
            deviceType = [@"ipad" copy];
        }
        else if ([deviceMode isEqualToString:@"iPod touch"]) {
            deviceType = [@"iphone" copy];
        }
    });
    return deviceType;
}

/**
 获取应用版本号
 
 @return 应用版本号
 */
+ (NSString *)APPVersion
{
    static NSString *appVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    });
    return appVersion;
}

/**
 获取应用Build号
 
 @return 应用Build号
 */
+ (NSInteger)APPBuild
{
    static NSUInteger appBuild;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appBuild = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] integerValue];
    });
    return appBuild;
}

/**
 获取当前网络类型
 
 @return 当前网络类型
 */
+ (NSString *)networkType
{
    NSString *networkType = nil;
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi: networkType = @"WIFI";
            break;
            
        case AFNetworkReachabilityStatusReachableViaWWAN: networkType = @"MOBILE";
            break;
            
        default: networkType = @"NONE";
            break;
    }
    return networkType;
}

@end
