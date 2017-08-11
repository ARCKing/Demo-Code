//
//  newVC.m
//  弹框
//
//  Created by root on 16/10/31.
//  Copyright © 2016年 root. All rights reserved.
//

#import "newVC.h"

@implementation newVC

- (void)viewDidLoad{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.alpha = 0.5;

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(122, 220, 100, 100);
    
    button.backgroundColor =[UIColor redColor];
    
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)dismiss{
    
   
    
    [self dismissViewControllerAnimated:YES completion:nil];




}

@end
