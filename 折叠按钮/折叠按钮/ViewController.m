//
//  ViewController.m
//  折叠按钮
//
//  Created by 丁宗凯 on 16/7/4.
//  Copyright © 2016年 dzk. All rights reserved.
//

#import "ViewController.h"
#import "FoldStyleButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FoldStyleButton *button = [[FoldStyleButton alloc] initWithFrame:CGRectMake(100, 200, 50, 50) mainButtonBGImage:@"ordernormal" selectBGImage:@"orderselect" otherButtonsBGimages:@[@"zhuanyi",@"dianhua"]];
//    button.backgroundColor = [UIColor redColor];
    button.ButtonClickBlock = ^void(UIButton *button){
        NSLog(@"----%d/-",button.tag);
    };
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
