//
//  LHBaseController.m
//  tableViewDemo
//
//  Created by liuhao on 17/3/28.
//  Copyright © 2017年 liuhao. All rights reserved.
//

#import "LHBaseController.h"

@interface LHBaseController ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation LHBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 244.0)];;
    
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(244, 0, 0, 0);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewOffSetY:) name:@"kChangeTableViewOffSetYNotification" object:nil];
}


    //执行通知
- (void)changeTableViewOffSetY:(NSNotification *)noti {
    NSInteger index = [noti.object integerValue];
    self.index = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger tag = scrollView.tag;
    
    NSLog(@"%ld",tag);
    
    if (self.tableView.frame.origin.x / self.view.frame.size.width != self.index) {
        return;
    }
    
    
    //bollock
    !self.offSet ? : self.offSet(scrollView.contentOffset.y, self);
}

- (void)setTableViewOffSetY:(CGFloat)offSetY {

    NSLog(@"offSetY=%f",offSetY);

    
    if (self.tableView.contentOffset.y > 200 && offSetY > self.tableView.contentOffset.y) {

        NSLog(@"%f",self.tableView.contentOffset.y);
        NSLog(@"offSetY=%f",offSetY);
        
        return;
    }
    
    NSLog(@"%@", self);
    NSLog(@"%f", self.tableView.contentOffset.y);
    [self.tableView setContentOffset:CGPointMake(0, offSetY)];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
