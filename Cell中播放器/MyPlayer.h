//
//  MyPlayer.h
//  player
//
//  Created by root on 16/9/16.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MyPlayer : UIView

@property(nonatomic,strong)AVPlayer * player;
@property(nonatomic,strong)AVPlayerItem * playerIteam;
@property(nonatomic,strong)AVPlayerLayer * playerLayer;

@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UISlider * progressSlider;

@property(nonatomic,strong)UIButton * starOrStopButton;

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger playerState;

@property(nonatomic,strong)UIImageView * toolView;



- (instancetype)initPlaverWithURL:(NSString *)url andFram:(CGRect)fram;

- (void)getNewPlayerIteamWithUrl:(NSString *)Newurl;

@end
