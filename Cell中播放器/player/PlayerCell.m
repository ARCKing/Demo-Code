//
//  PlayerCell.m
//  player
//
//  Created by root on 16/9/16.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "PlayerCell.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width


@implementation PlayerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_W *9/16)];
        self.bgImageView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_bgImageView];
        self.bgImageView.userInteractionEnabled = YES;
        
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playButton.frame = CGRectMake(0, 0, SCREEN_W,SCREEN_W *9/16);
        self.playButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:95/255.0 blue:252/255.0 alpha:0.5];
        [self.contentView addSubview:_playButton];
        
        
    }
    
    
    
    return self;

}


@end
