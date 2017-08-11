//
//  nextVc.m
//  弹框
//
//  Created by root on 16/10/31.
//  Copyright © 2016年 root. All rights reserved.
//

#import "nextVc.h"
@implementation nextVc

- (void)viewDidLoad{

    self.view.backgroundColor = [UIColor purpleColor];

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(122, 220, 100, 100);
    
    button.backgroundColor =[UIColor redColor];
    
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)dismiss{
    
    
       [self.navigationController popViewControllerAnimated:YES];
    
       self.nt();

    
    
   }
@end
