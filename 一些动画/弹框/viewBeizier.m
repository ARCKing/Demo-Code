//
//  viewBeizier.m
//  弹框
//
//  Created by gxtc on 16/12/20.
//  Copyright © 2016年 root. All rights reserved.
//

#import "viewBeizier.h"

@implementation viewBeizier

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (void)drawRect:(CGRect)rect{

    UIBezierPath *mPath = [UIBezierPath bezierPath];
    [mPath moveToPoint:CGPointMake(50, 50)]; //创建一个点
    [mPath addLineToPoint:CGPointMake(50, 100)]; // 加条线,从点移动到另一个点
    [mPath addLineToPoint:CGPointMake(100, 100)]; // 加条线,从点移动到另一个点
    [mPath closePath];
    
   
    UIColor *fillColor = [UIColor whiteColor];          //设置颜色
    [fillColor set];                                    //填充颜色
    [mPath fill];                                       //贝塞尔线进行填充
    
    UIColor *sCol = [UIColor redColor];               //设置红色画笔线
    [sCol set];                                       //填充颜色
    [mPath stroke];
    
    
    //创建一个椭圆的贝塞尔曲线 半径相等 就是圆了
    UIBezierPath *mPath1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 30, 30)];
    [mPath1 fill];
    
}



@end
