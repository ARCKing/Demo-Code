//
//  SecondViewController.h
//  TimeLineStudy
//
//  Created byMX007 on 16/9/20.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITableViewCellDisplayAnimationStyle) {
    UITableViewCellDisplayAnimationStyleFade,	 //透明度变化
    UITableViewCellDisplayAnimationStyleScale,	 //缩放
    UITableViewCellDisplayAnimationStylePosition,//位置变化
    UITableViewCellDisplayAnimationStyleRotateX, //x轴旋转
    UITableViewCellDisplayAnimationStyleRotateY  //Y 轴旋转
};

@interface SecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
