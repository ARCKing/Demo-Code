//
//  ChannelIteamModel.h
//  SnapshotViewAfterScreenUpdatesAnimation
//
//  Created by gxtc on 2017/8/8.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "JSONModel.h"

//每个Cell模型数据
typedef NS_ENUM(NSUInteger, Status) {
    Status_MinusSign = 0, // 减号
    Status_UnPlusSign, // 未选
    Status_PlusSign, // 已选
};

@interface ChannelIteamModel : JSONModel

@property(nonatomic,copy)NSString<Optional>* _id;
@property(nonatomic,copy)NSString<Optional>* title;
@property(nonatomic,copy)NSString<Optional>* iconName;

@property(nonatomic,copy)NSString<Optional>* state;

@end
