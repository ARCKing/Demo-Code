//
//  cell.h
//  弹框
//
//  Created by root on 16/10/31.
//  Copyright © 2016年 root. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cell : UITableViewCell
@property(nonatomic,strong)UILabel * title;
@property(nonatomic,strong)UIImageView * img;



- (void)loadData:(NSString *)str;
@end
