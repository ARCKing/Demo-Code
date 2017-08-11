
//
//  UILabel+Methods.m
//  Spinner
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 筒子家族. All rights reserved.
//

#import "UILabel+Methods.h"

@implementation UILabel (Methods)

- (void)fontStyle:(NSString *)changeStr textColor:(UIColor *)color textSize:(CGFloat)size fontName:(NSString *)name fromRange:(int)range
{
    long length = [NSString stringWithFormat:@"%@",changeStr].length;

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:name size:size] range:NSMakeRange(range,length)];
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range,length)];
    
    self.attributedText = str;
}

@end
