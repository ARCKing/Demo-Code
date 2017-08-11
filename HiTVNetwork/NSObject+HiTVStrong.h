//
//  NSObject+HiTVStrong.h
//  HiTVNetwork
//
//  Created by Ningmeng on 16/9/10.
//  Copyright © 2016年 Ningmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __STRONG(_object) [self addStrongObject:_object]
#define __REMOVE(_object) [_object removeFromOwner]

// strongAlloc
#define __STRONGALLOC(_class, _strongObject) \
_class *_strongObject = [_class new]; \
__STRONG(_strongObject)

/**
 *  用于辅助HiTVSessionTaskManager完成网络请求管理
 */
@interface NSObject (HiTVStrong)

@property (readonly) id sessionTarget;

- (void)addStrongObject:(id)object;

- (void)removeStrongObject:(id)object;

- (void)removeFromOwner;

@end
