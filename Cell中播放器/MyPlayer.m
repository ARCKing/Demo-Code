//
//  MyPlayer.m
//  player
//
//  Created by root on 16/9/16.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "MyPlayer.h"

@implementation MyPlayer



/** 初始化播放器 */
- (instancetype)initPlaverWithURL:(NSString *)url andFram:(CGRect)fram{
    
    if (self = [super init]) {
     
        self.frame = fram;
        
        [self playerWithURL:url];
    }
    
    return self;
}





/** 初始化播放器*/
- (AVPlayer *)playerWithURL:(NSString *)url{
    
    if (!_player) {
        NSURL * urlString = [NSURL URLWithString:url];
        
        AVPlayerItem * iteam = [AVPlayerItem playerItemWithURL:urlString];
        _player  = [AVPlayer playerWithPlayerItem:iteam];
        _playerIteam = iteam;
        
        AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        playerLayer.frame = self.bounds;
        _playerLayer = playerLayer;
        
        [self.layer addSublayer:playerLayer];
        
        [self addTimer];
        [self.player play];
        
        [iteam addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self.player;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (_playerIteam && [keyPath isEqualToString:@"status"]) {
        
        [self toolViewCreat];
        
        NSLog(@"开车啦！ -- ^V^");
    }
    
    
    
}

/** 初始化工具栏*/
- (void)toolViewCreat{
    
    self.toolView = [[UIImageView alloc]initWithFrame:CGRectMake(0,self.frame.size.height * 6 / 7,self.frame.size.width,self.frame.size.height/7)];
    self.toolView.backgroundColor =[UIColor purpleColor];
    [self.toolView setImage:[UIImage imageNamed:@"new_homepage_focus_backview.png"]];
    [self addSubview:_toolView];
    self.toolView.userInteractionEnabled = YES;
    
    self.starOrStopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.starOrStopButton.frame = CGRectMake(0, 0, self.toolView.bounds.size.width/8, self.toolView.bounds.size.height * 3 / 4);
    self.starOrStopButton.center = CGPointMake(self.toolView.bounds.size.width/16/2 + 5, self.toolView.bounds.size.height /2);
    
    [self.toolView addSubview:_starOrStopButton];
    [self.starOrStopButton addTarget:self action:@selector(playAndStop) forControlEvents:UIControlEventTouchUpInside];
    [self.starOrStopButton setImage:[UIImage imageNamed:@"moviePause.png"] forState:UIControlStateNormal];
    self.starOrStopButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //    self.starOrStopButton.backgroundColor = [UIColor redColor];
    self.starOrStopButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.starOrStopButton.layer.cornerRadius = 6;
    self.starOrStopButton.clipsToBounds = YES;
    //播放状态
    self.playerState = 1;
    
    
    self.progressSlider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, self.toolView.bounds.size.width *10/16, self.toolView.bounds.size.height / 3)];
    self.progressSlider.center = CGPointMake(CGRectGetMaxX(self.starOrStopButton.frame) + self.toolView.bounds.size.width *10/16/2, self.toolView.bounds.size.height/2);
    
    self.progressSlider.minimumValue = 0;
    self.progressSlider.maximumValue = CMTimeGetSeconds(self.player.currentItem.duration);
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"active_recommand.png"] forState:UIControlStateNormal];
    [self.progressSlider setTintColor:[UIColor purpleColor]];
    
    [self.toolView addSubview:_progressSlider];
    
    [self.progressSlider addTarget:self action:@selector(sliderWillSlidering) forControlEvents:UIControlEventTouchDown];
    
    [self.progressSlider addTarget:self action:@selector(isSlidering) forControlEvents:UIControlEventTouchUpInside];
    
    [self.progressSlider addTarget:self action:@selector(sliderValueChanging) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.toolView.bounds.size.width *5/ 16, self.toolView.bounds.size.height * 2 / 3)];
    self.timeLabel.center = CGPointMake(CGRectGetMaxX(self.progressSlider.frame) + self.toolView.bounds.size.width *5/ 16/2, self.toolView.bounds.size.height/2);
    [self.toolView addSubview:_timeLabel];
    self.timeLabel.text = @"[00:00/00:00]";
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    singleTap.numberOfTapsRequired = 1; // 点击次数
//    [self addGestureRecognizer:singleTap];

    
    
    [UIView animateWithDuration:5 animations:^{
        
        self.toolView.alpha = 0;
    }];
}


- (void)handleSingleTap{

    NSLog(@"22papapapapapap");

}


/** 新的playerIteam*/
- (void)getNewPlayerIteamWithUrl:(NSString *)Newurl{

    AVPlayerItem * NewplayerIteam = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:Newurl]];
    
    [self.player replaceCurrentItemWithPlayerItem:NewplayerIteam];

}


/** 滑块将滑动*/
- (void)sliderWillSlidering{
    [self stopTimer];
    
    [self.starOrStopButton setImage:[UIImage imageNamed:@"moviePause.png"] forState:UIControlStateNormal];
    
}

/** 滑块正在滑动*/
- (void)isSlidering{
    
    [self addTimer];
    NSTimeInterval currentTime =  self.progressSlider.value;
    
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self.player play];
    
}

/** 滑块 Value 改变*/
- (void)sliderValueChanging{
    
    
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value/self.progressSlider.maximumValue;
    
    NSTimeInterval allTime = CMTimeGetSeconds(self.player.currentItem.duration);
    
    
    NSInteger  currentSecond = (NSInteger)currentTime % 60;
    NSInteger  currentMinute = currentTime / 60;
    
    
    NSInteger allSecond = (NSInteger)allTime % 60;
    NSInteger allMinute = allTime / 60;
    
    self.timeLabel.text = [NSString stringWithFormat:@"[%.2ld:%.2ld/%.2ld:%.2ld]",currentMinute,currentSecond,allMinute,allSecond];
    
}


/** 播放-暂停*/
- (void)playAndStop{
    
    NSLog(@"boobobobo");
    
    if (self.playerState == 1) {
        _playerState --;
        [self stopTimer];
        [self.player pause];
        [self.starOrStopButton setImage:[UIImage imageNamed:@"moviePlay.png"] forState:UIControlStateNormal];
        
    }else if (self.playerState == 0) {
        _playerState ++;
        [self addTimer];
        [self.player play];
        [self.starOrStopButton setImage:[UIImage imageNamed:@"moviePause.png"] forState:UIControlStateNormal];
        
    }
    
}


/** 添加定时器*/
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

/** 移除定时器*/
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

/** 获取时间*/
- (NSString *)currentTimeAndAllTime{
    NSTimeInterval  allTime = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval  currentTime = CMTimeGetSeconds(self.player.currentTime);
    
    NSInteger allTimeSecond = (NSInteger)allTime % 60;
    NSInteger allTimeMinute = allTime / 60;
    
    NSInteger currentSecond = (NSInteger)currentTime % 60;
    NSInteger currentMinute = currentTime / 60;
    
    self.progressSlider.value = currentTime;
    
    return [NSString stringWithFormat:@"[%.2ld:%.2ld/%.2ld:%.2ld]",currentMinute,currentSecond,allTimeMinute,allTimeSecond];
}


/** 刷新时间*/
- (void)updateTime{
    
    self.timeLabel.text = [self currentTimeAndAllTime];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    if (_toolView.alpha == 0) {
        [UIView animateWithDuration:1 animations:^{
            
            self.toolView.alpha = 1;
        }];
    }else {
        
        [UIView animateWithDuration:1 animations:^{
            
            self.toolView.alpha = 0;
        }];
    }
}


@end
