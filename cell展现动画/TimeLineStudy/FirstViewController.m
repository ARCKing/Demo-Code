//
//  FirstViewController.m
//  TimeLineStudy
//
//  Created by MX007 on 16/9/20.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "FirstViewController.h"

#import "MyCell.h"

@interface FirstViewController ()
{
    NSArray *array;
    NSMutableArray *_dataArr;
    NSInteger _num;
    NSTimer *_timer;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _num = 0;
    
    //源数组
    array = @[@{@"title":@"［西安交通大学南门］派送员：奥巴马",@"position":@"0"},@{@"title":@"［西北工业大学东门］派送员：花泽香菜花泽香菜花泽香菜",@"position":@"1"},@{@"title":@"［西安交通大学北门］派送员：奥巴马",@"position":@"1"},@{@"title":@"［西安交通大学西门］派送员：奥巴马",@"position":@"1"},@{@"title":@"［西安交通大学东门］派送员：花泽香菜花泽香菜花泽香菜",@"position":@"1"},@{@"title":@"［西安交通大学南门］派送员：花泽香菜花泽香菜花泽香菜香菜香菜香菜香菜香菜香菜",@"position":@"2"}];
    
    //用于构建表的数组
    _dataArr = [NSMutableArray array];
    
    [self loadCellWithRowAnimation];
    
}

- (void)loadCellWithRowAnimation
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        if (_num >=array.count) {
            _timer = nil;
            [_timer invalidate];
            return ;
        }
        [_dataArr addObject:array[_num]];
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:_num inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationTop];
        //        [self.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        
        _num ++;
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getCellHeightAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycell = @"mycell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:nil options:nil][0];
        cell.lable1.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setMycellWithDic:_dataArr[indexPath.row]];
    return cell;
}

- (float)getCellHeightAtIndex:(NSInteger)row
{
    NSString *str = _dataArr[row][@"title"];
    float strHeight = [self getNsstringHeight:str fontsize:17.0];
    return 60-21+strHeight;
}

- (float)getNsstringHeight:(NSString *)str fontsize:(float)size
{
    CGRect frame = [str boundingRectWithSize:CGSizeMake(LableWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:size],NSFontAttributeName, nil] context:nil];
    return frame.size.height;
}


@end
