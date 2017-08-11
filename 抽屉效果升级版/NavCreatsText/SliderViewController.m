//
//  SliderViewController.m
//  NavCreatsText
//
//  Created by gxtc on 17/1/19.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "SliderViewController.h"
#import "MyMainViewController.h"
#import "MyLeftViewController.h"
#import "mainView.h"
#import "leftView.h"
#import "MyMaskView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SliderViewController ()

@property (nonatomic,strong)UIView * mainViews;
@property (nonatomic,strong)UIView * leftViews;

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (instancetype)initWithMainVC:(UIViewController *)MainVC
                     andLeftVC:(UIViewController *)leftVC{
    
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor orangeColor];

        [self creatViews];
        
        
        if (!MainVC) {
            
            NSLog(@"空的");
        }
        
        self.mainViewControllers = MainVC;
        self.leftViewControllers = leftVC;
        
    }

    return self;
}



- (void)creatViews{
    mainView * mview = [[mainView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    mview.backgroundColor = [UIColor greenColor];
    leftView * lView = [[leftView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    lView.backgroundColor = [UIColor cyanColor];
    
    self.mainViews = mview;
    self.leftViews = lView;
    
    [self.view addSubview:lView];
    [self.view addSubview:mview];
    
    
    
}

- (void)setMainViewControllers:(UIViewController *)mainViewControllers{

    if (!mainViewControllers) {
        return;
    }
    
    //注意set方法（.;_）
    _mainViewControllers = mainViewControllers;
    
    [self addChildViewController:mainViewControllers];
    
    [self.mainViews addSubview:mainViewControllers.view];
    
    
}

- (void)setLeftViewControllers:(UIViewController *)leftViewControllers{

    if (!leftViewControllers) {
        return;
    }
    
    _leftViewControllers = leftViewControllers;
    
    [self addChildViewController:leftViewControllers];
    
    [self.leftViews addSubview:leftViewControllers.view];
    
    
    self.leftViews.transform = CGAffineTransformMakeTranslation(-200, 0);
    self.leftViews.transform = CGAffineTransformScale(self.leftViews.transform,0.5, 0.5);

}


- (void)showLeft{

    [UIView animateWithDuration:0.5 animations:^{
        
    
    self.mainViews.transform = CGAffineTransformMakeTranslation(200, 0);
    self.mainViews.transform = CGAffineTransformScale(self.mainViews.transform, 0.8, 0.8);
        
    self.leftViews.transform = CGAffineTransformIdentity;
    
    }];
    
}


- (void)closedLeft{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.mainViews.transform = CGAffineTransformIdentity;
        
        self.leftViews.transform = CGAffineTransformMakeTranslation(-200, 0);
        self.leftViews.transform = CGAffineTransformScale(self.leftViews.transform,0.5, 0.5);
        
    }];

}



#pragma mark- 控件左右菜单界面push所需要的navigationController,默认为mainVC的navigationController
//@return mainVC的navigationController

- (UINavigationController *)sliderNavigationController{
    
    if (self.mainViewControllers) {
        
        if ([self.mainViewControllers isKindOfClass:[UINavigationController class]]) {
            
            return (UINavigationController *)self.mainViewControllers;
        }else if(self.mainViewControllers.navigationController){
        
            return self.mainViewControllers.navigationController;
        }
        
    }
    return nil;
}


- (UITabBarController *)slidertabBarController{
    
    if (self.mainViewControllers) {
        
        if (self.mainViewControllers) {
            
            if ([self.mainViewControllers isKindOfClass:[UITabBarController class]]) {
                
                return (UITabBarController *)self.mainViewControllers;
            }
        }else if (self.mainViewControllers.tabBarController){
        
            return self.mainViewControllers.tabBarController;
        }
        
    }
    
    return nil;
}



@end
