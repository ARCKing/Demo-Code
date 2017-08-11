//
//  tabBarVc.m
//  CyhSlider
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "tabBarVc.h"
#import "CyhSliderVC.h"
#import "MainVC.h"
@interface tabBarVc ()<pushdelegate>

@end

@implementation tabBarVc

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[CyhSliderVC initCyhslider] AddSliderLeftItem:nil Itemtitlecolor:nil UImage:[UIImage imageNamed:@"hean.jpg"] Trag:self];
    //添加导航栏上的按钮，可添加图片或文字
    [CyhSliderVC initCyhslider].pudelegate = self;
    
   
   
}

- (void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = YES;
}

/**
 *  协议代理方法，用于侧滑左控制器跳转
 *
 *  @param trag <#trag description#>
 */
- (void)pushsubVC:(id)trag
{
    [self.navigationController pushViewController:trag animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
