//
//  ViewController.m
//  ThreeHUDtest
//
//  Created by gxtc on 17/2/7.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor =[ UIColor whiteColor];
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor =[ UIColor redColor];
    bt.frame = CGRectMake(50, 64, 50, 50);
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btAction:(UIButton*)bt{
    
//    [self showMBHUD];
      [self showSVHUD];

}


- (void)showSVHUD{

    [SVProgressHUD show];

    [self performSelector:@selector(dismissSVHUD) withObject:nil afterDelay:3.0];
}

- (void)showMBHUD{

    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.label.text = @"loading...";
    //    HUD.detailsLabel.text = @"开车!";
    //    HUD.mode = MBProgressHUDModeCustomView;
    //    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //    HUD.customView = [[UIImageView alloc] initWithImage:image];
    //    // Looks a bit nicer if we make it square.
    //    HUD.square = YES;
    
    HUD.contentColor = [UIColor colorWithHue:arc4random()%361/360.0 saturation:1.0 brightness:1.0 alpha:1.0];
    
    [self doSomeThing:HUD];
}


- (void)dismissSVHUD{

    [SVProgressHUD dismiss];

}

- (void)doSomeThing:(MBProgressHUD *)HUD{

    [HUD hideAnimated:YES afterDelay:3.0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
