//
//  SliderViewController.h
//  NavCreatsText
//
//  Created by gxtc on 17/1/19.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderViewController : UIViewController

@property (nonatomic,strong)UIViewController * mainViewControllers;
@property (nonatomic,strong)UIViewController * leftViewControllers;

// push所需要的navigationController 只能由mainVC 提供
@property (nonatomic, strong, readonly) UINavigationController *sliderNavigationController;

@property (nonatomic, strong, readonly) UITabBarController *slidertabBarController;



- (instancetype)initWithMainVC:(UIViewController *)MainVC andLeftVC:(UIViewController *)leftVC;


- (void)showLeft;

- (void)closedLeft;
@end
