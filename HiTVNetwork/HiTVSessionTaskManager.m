//
//  HiTVSessionTaskManager.m
//  HiTVNetwork
//
//  Created by Ningmeng on 16/9/9.
//  Copyright © 2016年 Ningmeng. All rights reserved.
//

#import "HiTVSessionTaskManager.h"

@interface HiTVSessionTaskItem : NSObject

@property (strong, nonatomic) NSMutableArray<HiTVSessionTask *> *tasks;

@end

@implementation HiTVSessionTaskItem

- (instancetype)init
{
    if (self = [super init]) {
        _tasks = [NSMutableArray array];
    }
    return self;
}

@end


@interface HiTVSessionTaskManager ()

@property (strong, nonatomic) NSMutableDictionary<NSString *, HiTVSessionTaskItem *> *sessionTasks;

@end

@implementation HiTVSessionTaskManager

+ (instancetype)sharedManager
{
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [self new];
    });
    return obj;
}

- (instancetype)init
{
    if (self = [super init]) {
        _sessionTasks = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (NSString *)sessionTaskKeyForTarget:(id)target
{
    NSString *className = NSStringFromClass([target class]);
    return className ? [NSString stringWithFormat:@"com.hitv.sessionTasksKey.%@", className] : nil;
}

- (void)startSessionTask:(HiTVSessionTask *)task forKey:(NSString *)taskKey
{
    if (taskKey == nil || task == nil) return;
    if (task.state == NSURLSessionTaskStateCompleted) return;
    
    @synchronized (self.sessionTasks) {
        HiTVSessionTaskItem *item = [self.sessionTasks objectForKey:taskKey];
        if (item == nil) {
            item = [HiTVSessionTaskItem new];
            [item.tasks addObject:task];
            [self.sessionTasks setObject:item forKey:taskKey];
        }
        else if (![item.tasks containsObject:task]) {
            [item.tasks addObject:task];
        }
    }
}

- (void)cancelSessionTask:(HiTVSessionTask *)task forKey:(NSString *)taskKey
{
    if (task.state != NSURLSessionTaskStateCompleted) {
        [task cancel];
    }
    
    if (taskKey == nil) return;
    
    @synchronized (self.sessionTasks) {
        HiTVSessionTaskItem *item = [self.sessionTasks objectForKey:taskKey];
        if (item) {
            if ([item.tasks containsObject:task]) {
                [item.tasks removeObject:task];
            }
            if (item.tasks.count == 0) {
                [self.sessionTasks removeObjectForKey:taskKey];
            }
        }
    }
}

- (void)cancelAllSessionTasksForKey:(NSString *)taskKey
{
    if (taskKey == nil) return;
    
    @synchronized (self.sessionTasks) {
        HiTVSessionTaskItem *item = [self.sessionTasks objectForKey:taskKey];
        if (item) {
            [item.tasks makeObjectsPerformSelector:@selector(cancel)];
            [item.tasks removeAllObjects];
            [self.sessionTasks removeObjectForKey:taskKey];
        }
    }
}

@end
