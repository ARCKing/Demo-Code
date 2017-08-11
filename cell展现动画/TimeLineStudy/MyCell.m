//
//  MyCell.m
//  TimeLineStudy
//
//  Created by MX007 on 16/9/20.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "MyCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@implementation MyCell

- (void)setMycellWithDic:(NSDictionary *)dic
{
    self.lable1.text = dic[@"title"];
    
    //动态计算标题高度 改变约束
    float h = [self getNsstringHeight:dic[@"title"] fontsize:17.0];
    self.lable1.sd_layout
    .heightIs(h);
    [self.lable1 updateLayout];
    
    self.redpoint.alpha = 0;
    
    //区分第一个还是最后一个信息
    if ([dic[@"position"] isEqualToString:@"0"]) {
        //最新的物流
        self.line.sd_layout
        .topSpaceToView(self.contentView,12);
        [self.line updateLayout];
        
        self.redpoint.alpha = 0.3;
        self.firstPoint.backgroundColor = [UIColor redColor];
        self.lable1.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        self.lable2.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
        
    }else if ([dic[@"position"] isEqualToString:@"2"]) {
        //最旧的物流
        self.line.sd_layout
        .bottomSpaceToView(self.contentView,60-21+h-15);
        [self.line updateLayout];
    }
    
    //此处必须写  更新约束
    [self setupAutoHeightWithBottomView:self.lable2 bottomMargin:3];
}

- (float)getNsstringHeight:(NSString *)str fontsize:(float)size
{
    CGRect frame = [str boundingRectWithSize:CGSizeMake(LableWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:size],NSFontAttributeName, nil] context:nil];
    return frame.size.height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


@end
