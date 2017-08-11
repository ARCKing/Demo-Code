//
//  ViewController.h
//  TimeLineStudy
//
//  Created by 张发行 on 16/9/20.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

