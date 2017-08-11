//
//  MyCell.h
//  TimeLineStudy
//
//  Created by MX007 on 16/9/20.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LableWidth [UIScreen mainScreen].bounds.size.width-37-15

@interface MyCell : UITableViewCell

@property (nonatomic,assign) NSInteger positionNum;//首 尾 中

@property (weak, nonatomic) IBOutlet UILabel *redpoint;

@property (weak, nonatomic) IBOutlet UILabel *firstPoint;

@property (weak, nonatomic) IBOutlet UILabel *line;

@property (weak, nonatomic) IBOutlet UILabel *lable1;

@property (weak, nonatomic) IBOutlet UILabel *lable2;

- (void)setMycellWithDic:(NSDictionary *)dic;

@end
