//
//  ViewController.m
//  TimeLineStudy
//
//  Created by 张发行 on 16/9/20.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
{
    NSArray *_dataArr;
}
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"时间轴 & cell动画";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArr = @[@"时间轴",@"cell显现动画"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        FirstViewController *first = [[FirstViewController alloc] init];
        [self.navigationController pushViewController:first animated:YES];
        
    }else {
        self.title = @"cell显现动画";
        SecondViewController *second = [[SecondViewController alloc] init];
        [self.navigationController pushViewController:second animated:YES];
    }
}

@end
