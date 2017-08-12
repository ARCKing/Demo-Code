//
//  ChannelManagerView.m
//  SnapshotViewAfterScreenUpdatesAnimation
//
//  Created by gxtc on 2017/8/8.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ChannelManagerView.h"
#import "CollectionViewCell.h"
#import "ChannelIteamModel.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self

@interface ChannelManagerView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionViewFlowLayout * flowLayout;


@property(nonatomic,strong)NSIndexPath * moveIndexPath;
@property(nonatomic,strong)NSIndexPath * originalIndexPath;
@property(nonatomic,strong)UIView * snapshotView;

@end

@implementation ChannelManagerView


- (instancetype)initWithFrame:(CGRect)frame{



    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{


    [self addSubview:self.channelCollectionView];

}


#pragma mark-长按手势排序
- (void)longPressActionWithGesture:(UIGestureRecognizer *)gesture{


    NSLog(@"将要排序");
    
    //触点位置
    CGPoint tounchPoint = [gesture locationInView:self.channelCollectionView];

    self.moveIndexPath = [self.channelCollectionView indexPathForItemAtPoint:tounchPoint];

    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            
            
            
            if (self.moveIndexPath.section == 0) {
                
                CollectionViewCell * cell = (CollectionViewCell *)[self.channelCollectionView cellForItemAtIndexPath:self.moveIndexPath];
                
                
                self.originalIndexPath = [self.channelCollectionView indexPathForItemAtPoint:tounchPoint];
                
                
                if (!self.originalIndexPath) {
                    
                    return;
                }
                
                
                self.snapshotView = [cell snapshotViewAfterScreenUpdates:YES];
                
                self.snapshotView.center = [gesture locationInView:self.channelCollectionView];
                
                [self.channelCollectionView addSubview:self.snapshotView];
                
                cell.hidden = YES;
                
                [UIView animateWithDuration:0.2 animations:^{
                    
                    self.snapshotView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                    self.snapshotView.alpha = 0.98;
                }];
            }
            
        } break;
        case UIGestureRecognizerStateChanged:{
        
            self.snapshotView.center = [gesture locationInView:self.channelCollectionView];
            
            if (self.moveIndexPath.section == 0) {
                
                
                if (self.moveIndexPath && ![self.moveIndexPath isEqual:self.originalIndexPath] && self.moveIndexPath.section == self.originalIndexPath.section  ) {
                    
                    NSMutableArray * arr = self.cellGroupItemArray[0];

                    NSInteger formIndex = self.originalIndexPath.item;
                    
                    NSInteger toIndex = self.moveIndexPath.item;
                    
                    if (formIndex < toIndex) {
                        
                        for (NSInteger i = formIndex;i < toIndex; i++) {
                            
                            [arr exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                            
                        }
                    
                    }else{
                    
                        for (NSInteger i = formIndex; i > toIndex; i--) {
                            
                            [arr exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                        }
                    
                    }
                    
                    
                    [self.channelCollectionView moveItemAtIndexPath:self.originalIndexPath toIndexPath:self.moveIndexPath];
                    
                    self.originalIndexPath = self.moveIndexPath;
                    
                }
                
            }
            
        }break;
        case UIGestureRecognizerStateEnded:{
            
           CollectionViewCell * cell = (CollectionViewCell *)[self.channelCollectionView cellForItemAtIndexPath:self.originalIndexPath];
        
            cell.hidden = NO;
        
            [self.snapshotView removeFromSuperview];
            
        } break;
        default:
            break;
    }
    
}



#pragma mark- 添加频道
- (void)addSelectIteamWithAnimationCell:(CollectionViewCell *)cell{

    NSMutableArray * arr = self.cellGroupItemArray[0];
    
    ChannelIteamModel * model = [[ChannelIteamModel alloc]init];
    
    
    model._id = cell.model._id;
    model.state = @"0";
    model.title = cell.model.title;
    model.iconName = cell.model.iconName;
    
    [arr addObject:model];
    
    
    UIView * snapshotView = [cell snapshotViewAfterScreenUpdates:YES];

    snapshotView.frame = [cell convertRect:cell.bounds toView:self];
    
    [self addSubview:snapshotView];
    
    [self.channelCollectionView reloadData];
    
    //关键句！！！！！！！！！！！！！！
    [self.channelCollectionView layoutIfNeeded];
    
    CollectionViewCell * newCell = (CollectionViewCell *)[self.channelCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:arr.count - 1 inSection:0]];
    
    newCell.hidden = YES;
    
    CGRect targetRect = [newCell convertRect:newCell.bounds toView:self];
    
    
    [UIView animateWithDuration:0.4 animations:^{
       
        snapshotView.frame = targetRect;
        
    } completion:^(BOOL finished) {
        
        [snapshotView removeFromSuperview];
        
        newCell.hidden = NO;
    }];
}


#pragma mark- 取消频道
- (void)deleteSelectItemWithAnimation:(CollectionViewCell *)cell{

    NSIndexPath * indexPath;
    
    NSMutableArray * arr = self.cellGroupItemArray[0];
    
    
    
    if (cell.indexPath.section == 0) {
        
        
        NSMutableArray * arr1 = self.cellGroupItemArray[1];

        for (ChannelIteamModel * model in arr1) {
            
            if (model._id == cell.model._id) {
                
                model.state = @"1";
                
            }
            
            
        }
        
    }
    
    
    
    if (cell.indexPath.section == 1) {
        
        for (int i = 0 ; i < arr.count; i++) {
            
            ChannelIteamModel * model = arr[i];
            
            if ([model.title isEqualToString:cell.model.title]) {
                
                indexPath  = [NSIndexPath indexPathForRow:i inSection:0];
                
            }
            
        }
    
        
        cell = (CollectionViewCell *)[self.channelCollectionView cellForItemAtIndexPath:indexPath];
        
    }

    
    
    [arr removeObject:cell.model];
    
    UIView * snapshotView = [cell snapshotViewAfterScreenUpdates:YES];

    snapshotView.frame = [cell convertRect:cell.bounds toView:self];
    
    [self addSubview:snapshotView];
    
    cell.hidden = YES;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        snapshotView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        
    } completion:^(BOOL finished) {
        
        [snapshotView removeFromSuperview];
        
        cell.hidden = NO;
        
        [self.channelCollectionView reloadData];
        
        [self.channelCollectionView layoutIfNeeded];

    }];
    
}


#pragma mark- CollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"我点击了第%ld行,第%ld个",indexPath.section,indexPath.row);
    
    NSMutableArray * arr = self.cellGroupItemArray[indexPath.section];
    
    ChannelIteamModel * model = arr[indexPath.row];
    
    
    NSLog(@"%@",model);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.nibCellString) {
    
      CollectionViewCell *  cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.nibCellString forIndexPath:indexPath];
        
    
        /* 使用xib 就不需要理会重用的问题！不然cell内容将不显示
        for (UIView * subView in cell.contentView.subviews) {
            
            [subView removeFromSuperview];
            
        }
       */
        
        NSMutableArray * arr = self.cellGroupItemArray[indexPath.section];
        
        cell.isEditing = self.isEditing;
        
        cell.model = arr[indexPath.row];
        
        cell.indexPath = indexPath;
        
        WEAK_SELF;
        cell.cellSelectSateBK = ^(CollectionViewCell * cell) {
            
            ChannelIteamModel * model = arr[cell.indexPath.row];

            
            if (cell.state == Status_PlusSign) {
                
                [cell.stateBt setImage:[UIImage imageNamed:@"icon_u_select"] forState:UIControlStateNormal];
                
                model.state = @"1";
                
                [self deleteSelectItemWithAnimation:cell];

            }else if (cell.state == Status_UnPlusSign) {
                
                [cell.stateBt setImage:[UIImage imageNamed:@"icon_s_select"] forState:UIControlStateNormal];

                model.state = @"2";

                //添加
                [weakSelf addSelectIteamWithAnimationCell:cell];

                
            }else if (cell.state == Status_MinusSign) {
                
                [cell.stateBt setImage:[UIImage imageNamed:@"icon_u_jian"] forState:UIControlStateNormal];

                model.state = @"0";

                [self deleteSelectItemWithAnimation:cell];
            }
            
        };
        
        
        return cell;

        
    }else{
    
        CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellString forIndexPath:indexPath];
    
    
        for (UIView * subView in cell.contentView.subviews) {
        
            [subView removeFromSuperview];
    
        }


        ChannelIteamModel * model = self.cellItemArry[indexPath.row];
    
        if (model) {
        
        }
    
        return cell;
    }
}

//头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *reusableview = nil;

    
    if (kind == UICollectionElementKindSectionHeader){
        
        UICollectionReusableView * sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.SectionHeaderString forIndexPath:indexPath];
        
        for (UIView * subView in [sectionHeader subviews]) {
            
            [subView removeFromSuperview];
        }
        
            UILabel * headView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.sizeForHeader.width, self.sizeForHeader.height)];
        
            if (indexPath.section == 0) {
                headView.text = [NSString stringWithFormat:@" 我的频道"];

            }else{
        
                headView.text = [NSString stringWithFormat:@" 频道列表"];

            }
        
            [sectionHeader addSubview:headView];
        
        reusableview = sectionHeader;
        
    }else if (kind == UICollectionElementKindSectionHeader){
    
        UICollectionReusableView * sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:self.SectionFooterString forIndexPath:indexPath];
    
        UILabel * footView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.sizeForHeader.width, self.sizeForHeader.height)];

        footView.text = [NSString stringWithFormat:@"%ld",indexPath.row];

        [sectionHeader addSubview:footView];
        
        reusableview = sectionHeader;
    }

    return reusableview;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSMutableArray * arr = self.cellGroupItemArray[section];
    return arr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.numberOfSections;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return self.sizeForItemForCell;
}


//设置每组section的边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return self.edgeInsetsForSection;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return self.minimumLineSpacingForSection;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return self.minimumInteritemSpacingForSection;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return self.sizeForHeader;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    return self.sizeForFoot;
}

#pragma mark- 初始化
- (UICollectionViewFlowLayout *)flowLayout{

    if (!_flowLayout) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        /* ***静态布局*** *
        _flowLayout.itemSize  = CGSizeMake(Screen_Width/4,Screen_Width/4);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.headerReferenceSize = CGSizeMake(Screen_Width, Screen_Width/10);
        _flowLayout.footerReferenceSize = CGSizeMake(Screen_Width, Screen_Width/10);
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        */
    }

    return _flowLayout;
}


- (UICollectionView *)channelCollectionView{

    if (!_channelCollectionView) {
        
        _channelCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height) collectionViewLayout:self.flowLayout];
        _channelCollectionView.delegate = self;
        _channelCollectionView.dataSource =self;
        _channelCollectionView.backgroundColor = [UIColor whiteColor];
    
        if (self.cellString) {
            //纯代码cell注册
            [_channelCollectionView registerClass:NSClassFromString(self.cellString) forCellWithReuseIdentifier:self.cellString];
        }
        
        
        if (self.nibCellString) {
            //Nib cell注册
            [_channelCollectionView registerNib:[UINib nibWithNibName:self.nibCellString bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:self.nibCellString];
            
        }
    
        
        if (self.SectionHeaderString) {
            //headView注册
            [_channelCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.SectionHeaderString];
        }
        
        if (self.SectionFooterString) {
            //footView注册
            [_channelCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:self.SectionFooterString];
        }
        
    
    }
    
    return  _channelCollectionView;
}



@end
