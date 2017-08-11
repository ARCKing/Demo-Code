//
//  ViewController.m
//  九宫格抽奖
//
//  Created by gxtc on 17/2/8.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ViewController.h"
#import "ChouJiangLuckView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    ChouJiangLuckView * cj = [[ChouJiangLuckView alloc]initWithFrame:self.view.bounds];
    cj.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cj];

    [cj getDataSource];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
