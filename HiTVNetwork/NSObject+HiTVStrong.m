//
//  NSObject+HiTVStrong.m
//  HiTVNetwork
//
//  Created by Ningmeng on 16/9/10.
//  Copyright © 2016年 Ningmeng. All rights reserved.
//

#import "NSObject+HiTVStrong.h"
#import <objc/runtime.h>

@interface HiTVStrong : NSObject

@property (strong, nonatomic) NSMutableArray *array;
@property (weak, nonatomic) id owner;

@end

@implementation HiTVStrong

- (NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray new];
    }
    return _array;
}

@end


@interface NSObject ()

@property (strong, readonly, nonatomic) HiTVStrong *stronger;

@end

@implementation NSObject (HiTVStrong)

- (HiTVStrong *)stronger
{
    HiTVStrong *_stronger = objc_getAssociatedObject(self, _cmd);
    if (!_stronger) {
        _stronger = [HiTVStrong new];
        objc_setAssociatedObject(self, _cmd, _stronger, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _stronger;
}

- (id)sessionTarget
{
    return self.stronger.owner;
}

- (void)addStrongObject:(id)object
{
    if (![self.stronger.array containsObject:object]) {
        [self.stronger.array addObject:object];
    }
    NSObject *ob = (NSObject *)object;
    ob.stronger.owner = self;
}

- (void)removeStrongObject:(id)object
{
    [self.stronger.array removeObject:object];
}

- (void)removeFromOwner
{
    if (self.stronger.owner) {
        [self.stronger.owner removeStrongObject:self];
    }
}

@end
