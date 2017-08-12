//
//  ChannelIteamModel.m
//  SnapshotViewAfterScreenUpdatesAnimation
//
//  Created by gxtc on 2017/8/8.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ChannelIteamModel.h"

@implementation ChannelIteamModel

+ (JSONKeyMapper *)keyMapper{
    
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"_id":@"id"}];
    
}


@end
