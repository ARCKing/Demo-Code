//
//  collection_Cell.m
//  弹框
//
//  Created by gxtc on 16/12/27.
//  Copyright © 2016年 root. All rights reserved.
//

#import "collection_Cell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface collection_Cell()

@property(nonatomic,strong)UIView * view;

@end

@implementation collection_Cell


//在此方法自定义添加控件
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self CreateUI];
        
        
        UIView * vi = [[UIView alloc]initWithFrame:CGRectMake(100, 20, 50, 50)];
        vi.backgroundColor = [UIColor greenColor];
        
        
        //====== 添加控件时 =====
        
        //不能这么添加！！！无法显示
        [self.contentView addSubview:vi];
        
        
        //======必须这么添加 =====
        //这样
        [self.contentView.layer addSublayer:vi.layer];
        //或者这样
        [self addSubview:vi];
        
        
    }
    return self;
}

//-(void)layoutSubviews{
- (void)CreateUI{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc]init];
        _headImageView.frame = CGRectMake(0, 0, 114*kWidth/750.00, 114*kWidth/750.00);
        _headImageView.layer.cornerRadius = 57*kWidth/750.00;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.backgroundColor =[ UIColor redColor];
        [self addSubview:_headImageView];
    }
    if(!_nameLable){
        _nameLable = [[UILabel alloc]init];
        _nameLable.frame = CGRectMake(0, 40, kWidth, kWidth/4);
        _nameLable.font = [UIFont systemFontOfSize:30*kWidth/750.00];
        [_nameLable setTextAlignment:NSTextAlignmentCenter];
        _nameLable.textColor = [UIColor blackColor];
        [self addSubview:_nameLable];
    }
  
}

@end
