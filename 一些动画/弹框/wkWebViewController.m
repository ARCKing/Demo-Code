//
//  wkWebViewController.m
//  弹框
//
//  Created by gxtc on 16/12/26.
//  Copyright © 2016年 root. All rights reserved.
//

#import "wkWebViewController.h"
#import <WebKit/WebKit.h>

@interface wkWebViewController ()
@property (nonatomic,strong)WKWebView * wkWeb;
@property (nonatomic,strong)UIWebView * web;
@end

@implementation wkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[ UIColor whiteColor];
    
    self.url = @"http://mp.weixin.qq.com/s/4tnQYbIszW7X7cTymWVRlw";
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
    
    
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
