//
//  fourView.m
//  弹框
//
//  Created by gxtc on 17/1/4.
//  Copyright © 2017年 root. All rights reserved.
//

#import "fourView.h"

@implementation fourView

- (void)drawRect:(CGRect)rect{


    CGContextRef contextRef = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(contextRef, [UIColor redColor].CGColor);
    CGContextMoveToPoint(contextRef, 10, 10);
    CGContextAddLineToPoint(contextRef, 50, 50);
    
    CGContextStrokePath(contextRef);
    //下面两句成对使用用于保存和释放上次绘图的状态 每次绘制最好是用这两句话包起来 这样设置的颜色和线条宽度不会变成通用设置了
        CGContextSaveGState(contextRef);
        CGContextRelease(contextRef);

}

@end
