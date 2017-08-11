//
//  MainVC.m
//  抽屉效果
//
//  Created by gxtc on 17/1/18.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "MainVC.h"
#import "mainv.h"
#import "LeftV.h"
#import "subVC.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MainVC ()

@property (nonatomic,strong)LeftV * leftView;
@property (nonatomic,strong)mainv * mainView;
@property (nonatomic,strong)subVC * subVc;

@property (nonatomic,assign)BOOL isOpen;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatLeftNavBarButton];
    
    [self creatViews];
}


- (void)creatViews{

    self.leftView = [[LeftV alloc]initWithFrame:CGRectMake(-100, 0, 200, SCREEN_HEIGHT)];
    self.leftView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.leftView];
    
    UIView * cub = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 50)];
    cub.backgroundColor = [UIColor orangeColor];
    [self.leftView addSubview:cub];
    
    self.mainView = [[mainv alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.mainView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.mainView];

}

- (void)creatLeftNavBarButton{

    UIBarButtonItem * leftBarBt = [[UIBarButtonItem alloc]initWithTitle:@"left" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction)];
    
    self.navigationItem.leftBarButtonItem = leftBarBt;
    
}

- (void)leftBarButtonAction{
    
    if (self.isOpen == NO) {
        
    [UIView animateWithDuration:1.0 animations:^{
        
        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(200, 0);
        
        self.mainView.transform = CGAffineTransformMakeTranslation(200, 0)
        ;
        
        self.leftView.transform = CGAffineTransformMakeTranslation(100, 0);

        
        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(200, 0);
        
        
    } completion:^(BOOL finished) {
       
        self.isOpen = YES;
        
    }];
    
    
    }else{
    
        [UIView animateWithDuration:1.0 animations:^{
            
            self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
            
            self.mainView.transform = CGAffineTransformIdentity
            ;
            
            self.leftView.transform = CGAffineTransformIdentity;
            self.tabBarController.tabBar.transform = CGAffineTransformIdentity;
            
            
        } completion:^(BOOL finished) {
            
            self.isOpen = NO;
            
        }];

    
    
    }
    
    
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
