//
//  imgCell.h
//  弹框
//
//  Created by gxtc on 16/12/28.
//  Copyright © 2016年 root. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imgCell : UITableViewCell




- (void)addData:(UIImage *)img andTitle:(NSString *)title andTime:(NSString *)time
        andRead:(NSString *)read andColour:(UIColor *)colour;

@end
