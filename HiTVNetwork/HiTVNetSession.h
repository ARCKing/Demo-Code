//
//  HiTVNetSession.h
//  HiTVNetwork
//
//  Created by Ningmeng on 16/9/9.
//  Copyright © 2016年 Ningmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>
#import "HiTVNetParams.h"

typedef NS_ENUM(NSInteger, HiTVNetResponseSerializerType)
{
    HiTVNetResponseSerializerTypeData = -1,   /**< 二进制数据类型*/
    HiTVNetResponseSerializerTypeJSON = 0,    /**< 默认JSON类型*/
    HiTVNetResponseSerializerTypeXML = 1,     /**< XML类型*/
    HiTVNetResponseSerializerTypePList = 2,   /**< PList类型（预留）*/
    HiTVNetResponseSerializerTypeImage = 3,   /**< Image类型（预留）*/
    HiTVNetResponseSerializerTypeCompound = 4 /**< 组合类型（预留）*/
};

@interface HiTVNetSession : NSObject

typedef void (^HiTVNetSessionCompletion)(HiTVNetSession *session, id responseObject, NSError *error);

@property (assign, nonatomic) HiTVNetResponseSerializerType responseSerializerType; /**< 响应的数据格式*/
@property (copy, nonatomic) NSSet *acceptableContentTypes; /**< 支持内容类型*/
@property (assign, nonatomic) NSTimeInterval timeoutInterval; /**< 超时时间，默认30秒*/
@property (assign, nonatomic) NSUInteger retryCount; /**< 请求失败时重试次数，默认0，即不重试*/

@property (assign, nonatomic) BOOL usingSSL; /**< 是否使用SSL（进行https请求，需要在[HiTVNetSession HiTVSecurityPolicy]方法中修改cer证书路径），默认为NO*/
@property (readonly) NSString *sessionTaskKey; /**< 此次网络请求的标识Key*/

/**
 *  发送Get请求
 *
 *  @param target     发起此次网络请求所在的位置（可传入对应的类或者类的实例，传nil即表示不使用HiTVSessionTaskManager进行管理）
 *  @param params     参数
 *  @param completion 回调
 */
- (void)sendGetRequestInTarget:(id)target withParams:(HiTVNetParams *)params completion:(HiTVNetSessionCompletion)completion;

/**
 *  发送Post请求
 *
 *  @param target     发起此次网络请求所在的位置（可传入对应的类或者类的实例，传nil即表示不使用HiTVSessionTaskManager进行管理）
 *  @param params     参数
 *  @param completion 回调
 */
- (void)sendPostRequestInTarget:(id)target withParams:(HiTVNetParams *)params completion:(HiTVNetSessionCompletion)completion;

@end


@interface HiTVNetSession (SSL)

/**
 设置安全证书路径

 @param path 路径
 */
+ (void)setCertificatePath:(NSString *)path;

/**
 *  进行https请求时需提供的自定义安全策略，当[HiTVNetSession usingSSL]为YES时会自动调用此方法
 *  注意：HiTVNetSession内部做了断言处理，当[HiTVNetSession usingSSL]为YES时，此方法必须返回一个有效的对象
 *  @return HiTV安全策略，path无效时，则返回nil
 */
+ (AFSecurityPolicy *)HiTVSecurityPolicy;

@end
