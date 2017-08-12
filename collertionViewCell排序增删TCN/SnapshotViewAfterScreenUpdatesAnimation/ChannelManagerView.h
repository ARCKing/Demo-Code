//
//  ChannelManagerView.h
//  SnapshotViewAfterScreenUpdatesAnimation
//
//  Created by gxtc on 2017/8/8.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelManagerView : UIView

@property (nonatomic,strong)UICollectionView * channelCollectionView;

@property(nonatomic,assign)BOOL isEditing;

/**数据源*/
@property(nonatomic,strong)NSMutableArray * cellItemArry;

/**组数据源*/
@property(nonatomic,strong)NSMutableArray * cellGroupItemArray;

/**cell个数*/
@property (nonatomic,assign)NSInteger numberOfItemsInSection;

/**cell组数*/
@property (nonatomic,assign)NSInteger numberOfSections;

/**cell大小*/
@property (nonatomic,assign)CGSize sizeForItemForCell;

/**cell最小行间距*/
@property (nonatomic,assign)CGFloat minimumLineSpacingForSection;

/**cell最小列间距*/
@property (nonatomic,assign)CGFloat minimumInteritemSpacingForSection;

/**每组section边距(top,bottom,left,right)*/
@property (nonatomic,assign)UIEdgeInsets edgeInsetsForSection;

/**头部视图尺寸*/
@property (nonatomic,assign)CGSize sizeForHeader;

/**为不是图尺寸*/
@property (nonatomic,assign)CGSize sizeForFoot;

//*** ReuseIdentifier ***
@property (nonatomic,copy)NSString * cellString;

@property (nonatomic,copy)NSString * nibCellString;

@property (nonatomic,copy)NSString * SectionHeaderString;

@property (nonatomic,copy)NSString * SectionFooterString;


//排序
- (void)longPressActionWithGesture:(UIGestureRecognizer *)gesture;

@end
