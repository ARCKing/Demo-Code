//
//  PlayerCell.h
//  player
//
//  Created by root on 16/9/16.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell

@property(nonatomic,retain)NSString * videoUrl;


@property(nonatomic,strong)UIButton * playButton;

@property(nonatomic,strong)UIImageView * bgImageView;



@end
