//
//  HiTVSessionTaskManager.h
//  HiTVNetwork
//
//  Created by Ningmeng on 16/9/9.
//  Copyright © 2016年 Ningmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSURLSessionTask HiTVSessionTask;

/**
 *  管理网络请求
 *  可用于当一个对象里的网络请求还没完成，对象已经被关闭时，可用此类来关闭对象里的网络请求
 *  可防止对象被持有而无法被释放
 */
@interface HiTVSessionTaskManager : NSObject

+ (instancetype)sharedManager;

/**
 *  获取此次网络请求的标识Key，需传入对应的类或者类的实例
 *
 *  @param target 对应的类或者类的实例
 *
 *  @return 标识Key
 */
+ (NSString *)sessionTaskKeyForTarget:(id)target;

- (void)startSessionTask:(HiTVSessionTask *)task forKey:(NSString *)taskKey;

- (void)cancelSessionTask:(HiTVSessionTask *)task forKey:(NSString *)taskKey;

- (void)cancelAllSessionTasksForKey:(NSString *)taskKey;

@end
