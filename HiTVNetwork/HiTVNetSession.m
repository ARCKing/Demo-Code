//
//  HiTVNetSession.m
//  HiTVNetwork
//
//  Created by Ningmeng on 16/9/9.
//  Copyright © 2016年 Ningmeng. All rights reserved.
//

#import "HiTVNetSession.h"

#import <MJExtension/MJExtension.h>
#import "HiTVNetConst.h"
#import "HiTVSessionTaskManager.h"

#define HiTV_CHECK_ERROR \
NSError *error = [params validate]; \
if (error) { \
    if (completion) completion(self, nil, error); \
    return; \
}




typedef NS_ENUM(NSInteger, HiTVNetHttpMethodType)
{
    HiTVNetHttpMethodTypeGET = 0,
    HiTVNetHttpMethodTypePOST = 1
};

typedef NS_ENUM(NSInteger, HiTVNetSessionTaskOperationType)
{
    HiTVNetSessionTaskOperationTypeStart = 0,
    HiTVNetSessionTaskOperationTypeCancel = 1
};

@implementation HiTVNetSession

#pragma mark - Setter & Getter

- (NSSet *)acceptableContentTypes
{
    if (_acceptableContentTypes == nil) {
        _acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    }
    return _acceptableContentTypes;
}

- (NSTimeInterval)timeoutInterval
{
    if (_timeoutInterval <= 0.0) {
        _timeoutInterval = HiTV_NET_SESSION_DEFAULT_TIMEOUT_INTERVAL;
    }
    return _timeoutInterval;
}

#pragma mark - Public

/**
 *  发送Get请求
 *
 *  @param target     发起此次网络请求所在的位置（可传入对应的类或者类的实例）
 *  @param param      参数
 *  @param completion 回调
 */
- (void)sendGetRequestInTarget:(id)target withParams:(HiTVNetParams *)params completion:(HiTVNetSessionCompletion)completion
{
    HiTV_CHECK_ERROR
    _sessionTaskKey = [HiTVSessionTaskManager sessionTaskKeyForTarget:target];
    [self startGetRequestWithUrl:[params url] data:[params postParameters] completion:completion];
}

/**
 *  发送Post请求
 *
 *  @param target     发起此次网络请求所在的位置（可传入对应的类或者类的实例）
 *  @param params     参数
 *  @param completion 回调
 */
- (void)sendPostRequestInTarget:(id)target withParams:(HiTVNetParams *)params completion:(HiTVNetSessionCompletion)completion
{
    HiTV_CHECK_ERROR
    _sessionTaskKey = [HiTVSessionTaskManager sessionTaskKeyForTarget:target];
    [self startPostRequestWithUrl:[params url] data:[params postParameters] completion:completion];
}

#pragma mark - Private

- (void)startGetRequestWithUrl:(NSString *)urlString data:(id)data completion:(HiTVNetSessionCompletion)completion
{
    [self startURLRequestWithUrl:urlString httpMethod:HiTVNetHttpMethodTypeGET postData:data retryCount:0 completion:completion];
}

- (void)startPostRequestWithUrl:(NSString *)urlString data:(id)data completion:(HiTVNetSessionCompletion)completion
{
    [self startURLRequestWithUrl:urlString httpMethod:HiTVNetHttpMethodTypePOST postData:data retryCount:0 completion:completion];
}

- (void)startURLRequestWithUrl:(NSString *)urlString
                    httpMethod:(HiTVNetHttpMethodType)httpMethod
                      postData:(id)postData
                    retryCount:(NSUInteger)retryCount
                    completion:(HiTVNetSessionCompletion)completion
{
    NSLog(@"URLString = %@", urlString);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = self.timeoutInterval;
    
    if (self.responseSerializerType == HiTVNetResponseSerializerTypeXML) {
        manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    }
    else if (self.responseSerializerType == HiTVNetResponseSerializerTypePList) {
        manager.responseSerializer = [AFPropertyListResponseSerializer serializer];
    }
    else if (self.responseSerializerType == HiTVNetResponseSerializerTypeImage) {
        manager.responseSerializer = [AFImageResponseSerializer serializer];
    }
    else if (self.responseSerializerType == HiTVNetResponseSerializerTypeCompound) {
        manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    }
    else if (self.responseSerializerType == HiTVNetResponseSerializerTypeData) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    NSSet *acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:self.acceptableContentTypes];
    manager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    
    if (self.usingSSL) {
        AFSecurityPolicy *securityPolicy = [HiTVNetSession HiTVSecurityPolicy];
        NSAssert(securityPolicy, @"Must return a valid AFSecurityPolicy instance when using SSL.");
        [manager setSecurityPolicy:securityPolicy];
    }
    
    HiTV_NET_WEAK_SELF
    HiTVSessionTask *sessionTask;
    if (httpMethod == HiTVNetHttpMethodTypeGET) {
        
        sessionTask = [manager GET:urlString parameters:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [weakSelf manageSessionTask:task withData:responseObject error:nil completion:completion];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (retryCount >= weakSelf.retryCount) {
                [weakSelf manageSessionTask:task withData:nil error:error completion:completion];
            }
            else {
                [weakSelf manageSessionTask:task withOperationType:HiTVNetSessionTaskOperationTypeCancel];
                [weakSelf startURLRequestWithUrl:urlString httpMethod:httpMethod postData:postData retryCount:retryCount + 1 completion:completion];
            }
        }];
    }
    else {
        sessionTask = [manager POST:urlString parameters:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf manageSessionTask:task withData:responseObject error:nil completion:completion];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (retryCount >= weakSelf.retryCount) {
                [weakSelf manageSessionTask:task withData:nil error:error completion:completion];
            }
            else {
                [weakSelf manageSessionTask:task withOperationType:HiTVNetSessionTaskOperationTypeCancel];
                [weakSelf startURLRequestWithUrl:urlString httpMethod:httpMethod postData:postData retryCount:retryCount + 1 completion:completion];
            }
        }];
    }
    
    [self manageSessionTask:sessionTask withOperationType:HiTVNetSessionTaskOperationTypeStart];
}

- (void)manageSessionTask:(HiTVSessionTask *)task withData:(id)responseObject error:(NSError *)error completion:(HiTVNetSessionCompletion)completion
{
    [self manageSessionTask:task withOperationType:HiTVNetSessionTaskOperationTypeCancel];
    
    // 网络请求被主动关闭了，就释放回调
    if (error && error.code == kHiTVNetErrorRequestCanceled) {
        if (completion) completion = nil;
        return;
    }
    
    // 正常回调
    if (completion) completion(self, responseObject, error);
}

- (void)manageSessionTask:(HiTVSessionTask *)task withOperationType:(HiTVNetSessionTaskOperationType)type
{
    if (type == HiTVNetSessionTaskOperationTypeCancel) {
        // 结束一个已有的请求，将其从任务管理队列中移除
        [[HiTVSessionTaskManager sharedManager] cancelSessionTask:task forKey:self.sessionTaskKey];
    }
    else {
        // 开始一个新的请求，将其加入到任务管理队列中
        [[HiTVSessionTaskManager sharedManager] startSessionTask:task forKey:self.sessionTaskKey];
    }
}

#pragma mark - dealloc

- (void)dealloc
{
    NSLog(@"%@ dealloc.", [[self class] description]);
}

@end


#pragma mark - HiTVNetSession+SSL

@interface HiTVSecurityPolicyStatic : NSObject

@property (copy, nonatomic) NSString *path;

@end

@implementation HiTVSecurityPolicyStatic

+ (instancetype)sharedInstance
{
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [self new];
    });
    return obj;
}

- (void)setCertificatePath:(NSString *)path
{
    [self setPath:path];
}

@end


@implementation HiTVNetSession (SSL)

+ (void)setCertificatePath:(NSString *)path
{
    [[HiTVSecurityPolicyStatic sharedInstance] setCertificatePath:path];
}

+ (AFSecurityPolicy *)HiTVSecurityPolicy
{
    AFSecurityPolicy *hitvSecurityPolicy;
    NSString *certificatePath = [HiTVSecurityPolicyStatic sharedInstance].path;
    NSData *certificatePathData = [NSData dataWithContentsOfFile:certificatePath];
    if (certificatePathData) {
        NSSet <NSData *> *certificates = [NSSet setWithObject:certificatePathData];
        hitvSecurityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certificates];
        [hitvSecurityPolicy setAllowInvalidCertificates:NO];
        [hitvSecurityPolicy setValidatesDomainName:YES];
    }
    return hitvSecurityPolicy;
}

@end
