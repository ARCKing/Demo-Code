//
//  lbl_IntroPrizView.m
//  Spinner
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 筒子家族. All rights reserved.
//

#import "lbl_IntroPrizView.h"

@implementation lbl_IntroPrizView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    UIButton *readyb = [UIButton buttonWithType:UIButtonTypeCustom];
    readyb.backgroundColor = [UIColor blueColor];
    readyb.frame = CGRectMake((CGRectGetWidth(self.frame)-70)/2.0, 10, 70, 50);
    [readyb setTitle:@"关闭" forState:UIControlStateNormal];
    [readyb addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:readyb];
}

- (void)close
{
    if (_block) {
        _block();
    }
}

@end
