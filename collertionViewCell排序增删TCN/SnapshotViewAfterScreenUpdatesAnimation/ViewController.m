//
//  ViewController.m
//  SnapshotViewAfterScreenUpdatesAnimation
//
//  Created by gxtc on 2017/8/8.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ViewController.h"
#import "ChannelManagerView.h"
#import "ChannelIteamModel.h"
#import "ChannelIteamGroupModel.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self


@interface ViewController ()

@property(nonatomic,strong)ChannelManagerView * channelMangerView;

@property(nonatomic,strong)NSMutableArray * dataArr;

@property(nonatomic,strong)UIView * headNavView;

@property(nonatomic,assign)BOOL isEditing;

@property(nonatomic,strong)UILongPressGestureRecognizer * longPressGesture;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headNavView];
    
    NSArray * data = @[
                       
                       @{@"id":@"01",@"title":@"地图",@"iconName":@"01"},
                       @{@"id":@"02",@"title":@"黄昏",@"iconName":@"02"},
                       @{@"id":@"03",@"title":@"鬼城",@"iconName":@"03"},
                       @{@"id":@"04",@"title":@"城堡",@"iconName":@"04"},
                       @{@"id":@"05",@"title":@"降落伞",@"iconName":@"05"},
                       @{@"id":@"06",@"title":@"深海",@"iconName":@"06"},
                       @{@"id":@"07",@"title":@"电视",@"iconName":@"07"},
                       @{@"id":@"08",@"title":@"地球",@"iconName":@"08"},
                       @{@"id":@"09",@"title":@"傍晚",@"iconName":@"09"},
                       @{@"id":@"10",@"title":@"河流",@"iconName":@"10"},
                       @{@"id":@"11",@"title":@"大鸟",@"iconName":@"11"},

                       ];
    
    
    NSMutableArray * array = [NSMutableArray new];
    
    for (NSDictionary * dic in data) {
        
        ChannelIteamModel * model = [[ChannelIteamModel alloc]initWithDictionary:dic error:nil];
        model.state = @"1";
        [array addObject:model];
    }
    
    self.dataArr = array;
    
    [self.view addSubview:self.channelMangerView];
}


- (ChannelManagerView *)channelMangerView{

    if (!_channelMangerView) {
        
        _channelMangerView = [[ChannelManagerView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
        
        NSMutableArray * group = [NSMutableArray arrayWithObjects:[NSMutableArray new],self.dataArr, nil];
        
        _channelMangerView.cellGroupItemArray = group;
        _channelMangerView.numberOfSections = group.count;

        _channelMangerView.sizeForItemForCell = CGSizeMake(Screen_Width/4 , Screen_Width/4);
        _channelMangerView.edgeInsetsForSection = UIEdgeInsetsMake(0, 0, 0, 0);
        _channelMangerView.minimumLineSpacingForSection = 0;
        _channelMangerView.minimumInteritemSpacingForSection = 0;
        
        _channelMangerView.nibCellString = @"CollectionViewCell";
        
        _channelMangerView.SectionHeaderString = @"1";
        _channelMangerView.SectionFooterString = @"2";
        
        _channelMangerView.sizeForHeader = CGSizeMake(Screen_Width, Screen_Width/10);
        _channelMangerView.sizeForFoot = CGSizeMake(0, 0);
        
        [_channelMangerView.channelCollectionView addGestureRecognizer:self.longPressGesture];
    }
    return _channelMangerView;
}


- (UIView *)headNavView{

    if (!_headNavView) {
        
        _headNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
        _headNavView.backgroundColor = [UIColor redColor];
        
        UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitle:@"管理频道" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(manageBtAction) forControlEvents:UIControlEventTouchUpInside];
        rightButton.frame = CGRectMake(Screen_Width - Screen_Width/4, 20, Screen_Width/4, 44);
        [_headNavView addSubview:rightButton];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _headNavView;
}

- (void)manageBtAction{

    NSLog(@"管理");

    self.isEditing = !self.isEditing;
    
    self.channelMangerView.isEditing = self.isEditing;
    [self.channelMangerView.channelCollectionView reloadData];
    
   
}

- (UILongPressGestureRecognizer *)longPressGesture{
    
    if (!_longPressGesture) {
        
        _longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureAction:)];
    }
    return _longPressGesture;
}

#pragma mark- 手势响应
- (void)longPressGestureAction:(UILongPressGestureRecognizer *)recoginzer{
    
    NSLog(@"手势---手势");
   
    //！！！关键- 编辑当中只能reloadData 1次
    if (!self.isEditing) {
        self.isEditing = YES;
        self.channelMangerView.isEditing = YES;
        
        [self.channelMangerView.channelCollectionView layoutIfNeeded];
        [self.channelMangerView.channelCollectionView reloadData];
    }
    
    [self.channelMangerView longPressActionWithGesture:recoginzer];

}

@end
