//
//  collection_TwoCell.m
//  弹框
//
//  Created by gxtc on 16/12/27.
//  Copyright © 2016年 root. All rights reserved.
//

#import "collection_TwoCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@implementation collection_TwoCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self CreateUI];
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
        [self addSubview:_headImageView];
    }
    if(!_nameLable){
        _nameLable = [[UILabel alloc]init];
        _nameLable.frame = CGRectMake(0, 60*kWidth/750.00, 114*kWidth/750.00, 40*kWidth/750.00);
        _nameLable.font = [UIFont systemFontOfSize:30*kWidth/750.00];
        [_nameLable setTextAlignment:NSTextAlignmentCenter];
        _nameLable.textColor = [UIColor blackColor];
        [_headImageView addSubview:_nameLable];
    }
   
}
@end
