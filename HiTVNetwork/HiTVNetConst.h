//
//  HiTVNetConst.h
//  hitv
//
//  Created by Ningmeng on 2016/10/8.
//  Copyright © 2016年 Zapper. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! @abstract -999: The request has been canceled. */
extern NSInteger const kHiTVNetErrorRequestCanceled;

/*! @abstract -1001: The request timed out on the server. */
extern NSInteger const kHiTVNetErrorRequestTimeout;

/*! @abstract -1009: The Internet connection appears to be offline. */
extern NSInteger const kHiTVNetErrorRequestInternetOffline;

/*! @abstract -4000: Something unknow error occured, use the common error code instead. */
extern NSInteger const kHiTVNetErrorCommon;

/*! The common error domain for HiTV net. */
FOUNDATION_EXPORT NSErrorDomain const HiTVNetCommonErrorDomain;

// 弱引用
#define HiTV_NET_WEAK_SELF typeof(self) __weak weakSelf = self;

// 构建错误
#define HiTV_NET_ERROR(__msg, __code)                                                                    \
({                                                                                                       \
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:__msg forKey:NSLocalizedDescriptionKey]; \
    [NSError errorWithDomain:HiTVNetCommonErrorDomain code:__code userInfo:userInfo];                    \
})

// 通用网络请求异常错误
#define HiTV_NET_ERROR_COMMON HiTV_NET_ERROR(@"网络异常", kHiTVNetErrorCommon)

// 网络请求默认超时时间（单位：秒）
#define HiTV_NET_SESSION_DEFAULT_TIMEOUT_INTERVAL (30.0)

@interface HiTVNetConst : NSObject

/**
 获取设备类型

 @return 设备类型
 */
+ (NSString *)DeviceType;

/**
 获取应用版本号

 @return 应用版本号
 */
+ (NSString *)APPVersion;

/**
 获取应用Build号

 @return 应用Build号
 */
+ (NSInteger)APPBuild;

/**
 获取当前网络类型

 @return 当前网络类型
 */
+ (NSString *)networkType;

@end
