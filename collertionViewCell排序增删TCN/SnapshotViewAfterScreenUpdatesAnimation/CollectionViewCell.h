//
//  CollectionViewCell.h
//  SnapshotViewAfterScreenUpdatesAnimation
//
//  Created by gxtc on 2017/8/9.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelIteamModel.h"

@class CollectionViewCell;

typedef void(^cellSelectStateBlock)(CollectionViewCell *);


@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *BGView;

@property (nonatomic,strong)ChannelIteamModel * model;

@property (nonatomic,assign)BOOL isEditing;

@property (weak, nonatomic) IBOutlet UIButton *stateBt;

@property (nonatomic,copy)cellSelectStateBlock cellSelectSateBK;

@property (nonatomic,assign)NSInteger state;

@property (nonatomic,strong)NSIndexPath * indexPath;
@end
