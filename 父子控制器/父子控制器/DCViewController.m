//
//  DCViewController.m
//  父子控制器
//
//  Created by 戴川 on 16/6/3.
//  Copyright © 2016年 戴川. All rights reserved.
//


#define DCScreenW    [UIScreen mainScreen].bounds.size.width
#define DCScreenH    [UIScreen mainScreen].bounds.size.height


#import "DCViewController.h"
#import "DCNavTabBarController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@implementation DCViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"总控制器";
    
    OneViewController *oneView = [[OneViewController alloc]init];
    oneView.title = @"第一页";
    TwoViewController *twoView = [[TwoViewController alloc]init];
    twoView.title = @"第二页";
    ThreeViewController *threeView = [[ThreeViewController alloc]init];
    threeView.title = @"第三页";

    
    NSArray *subViewControllers = @[oneView,twoView,threeView];
    
    DCNavTabBarController *tabBarVC = [[DCNavTabBarController alloc]initWithSubViewControllers:subViewControllers];
    
    tabBarVC.view.frame = CGRectMake(0, 64, DCScreenW, DCScreenH - 64);
    
    [self.view addSubview:tabBarVC.view];
    
    [self addChildViewController:tabBarVC];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
