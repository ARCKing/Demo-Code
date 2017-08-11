//
//  MyMainViewController.m
//  NavCreatsText
//
//  Created by gxtc on 17/1/19.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "MyMainViewController.h"
#import "SliderViewController.h"
#import "UIViewController+UIViewController_SliderVC.h"

@interface MyMainViewController ()

@property(nonatomic,assign)BOOL isShow;
@property(nonatomic,assign)SliderViewController * sliderVC;


@end

@implementation MyMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sliderVC = [self sliderViewController];
    
    [self craetLeftBarIteam];

    [self creatButton];
    
    
}


- (void)craetLeftBarIteam{
    UIBarButtonItem  * leftIteam = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:UIBarButtonItemStyleDone target:self action:@selector(leftButtonActions)];
    
    self.navigationItem.leftBarButtonItem = leftIteam;
}



- (void)leftButtonActions{

    if (!self.isShow) {
        
//        [[self sliderViewController]showLeft];
        
        [self.sliderVC showLeft];
        
        self.isShow = YES;

    }else{
        
        [[self sliderViewController]closedLeft];
        
        self.isShow = NO;

    }
}


- (void)creatButton{

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"个人中心" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
#pragma mark- button.tag-1100+i
    button.tag = 1100 ;
    button.frame = CGRectMake(50, 100, 150, 30);
    [self.view addSubview:button];


}



- (void)btAction{

    UIViewController * vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    
    [self.navigationController pushViewController:vc animated:YES];
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
