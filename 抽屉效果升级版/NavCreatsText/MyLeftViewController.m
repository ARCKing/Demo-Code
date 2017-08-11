//
//  MyLeftViewController.m
//  NavCreatsText
//
//  Created by gxtc on 17/1/19.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "MyLeftViewController.h"
#import "SliderViewController.h"
#import "UIViewController+UIViewController_SliderVC.h"
@interface MyLeftViewController ()

@end

@implementation MyLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatButton];
}

- (void)creatButton{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"奖牌榜" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
#pragma mark- button.tag-1100+i
    button.tag = 1100 ;
    button.frame = CGRectMake(50, 100, 150, 30);
    [self.view addSubview:button];
    
    
}



- (void)btAction{
    
    UIViewController * vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor yellowColor];

    [[self sliderViewController]closedLeft];
    
    
    //NavigationController
//    [[self sliderViewController].sliderNavigationController pushViewController:vc animated:YES];
    
    
    //UITabBarController
    UITabBarController * tab = [self sliderViewController].slidertabBarController;
    
    [tab.selectedViewController pushViewController:vc animated:YES];
    
    
    
    
    
}


@end
