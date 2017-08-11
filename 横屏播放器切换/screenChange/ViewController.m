//
//  ViewController.m
//  screenChange
//
//  Created by gxtc on 16/9/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//




#import "ViewController.h"
#import "MyPlayer.h"
#import "Masonry.h"

#define MP4URL1 @"http://flv2.bn.netease.com/videolib3/1609/18/EYlMz2608/SD/EYlMz2608-mobile.mp4"
#define MP4URL2 @"http://flv2.bn.netease.com/videolib3/1609/18/uTFOP2452/SD/uTFOP2452-mobile.mp4"
#define MP4URL3 @"http://flv2.bn.netease.com/videolib3/1609/18/LsxZD2622/SD/LsxZD2622-mobile.mp4"
#define MP4URL4 @"http://flv2.bn.netease.com/videolib3/1609/18/aqDKY3330/SD/aqDKY3330-mobile.mp4"
#define MP4URL5 @"http://flv2.bn.netease.com/videolib3/1609/17/QiIoz0426/SD/QiIoz0426-mobile.mp4"

#define Screen_W self.view.bounds.size.width
#define Screen_H self.view.bounds.size.height


@interface ViewController ()
@property(nonatomic,retain)MyPlayer * avPlayer;

@property(nonatomic,assign)BOOL isFullScreen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _isFullScreen = NO;
    
    _avPlayer = [[MyPlayer alloc]initPlaverWithURL:MP4URL1 andFram:CGRectMake(0, 0, Screen_W, Screen_W *9/16)];
    
    [self.view addSubview:_avPlayer];
    
    
    [self.avPlayer.fullScreeButton addTarget:self action:@selector(fullScreen) forControlEvents:UIControlEventTouchUpInside];
}





- (void)fullScreen{
    NSLog(@"全屏");
    
    
    if (_isFullScreen == NO) {
        [_avPlayer removeFromSuperview];
        _avPlayer.toolView.alpha = 0;
        _avPlayer.transform = CGAffineTransformIdentity;
        _avPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        
            _avPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            _avPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);

        
        
        
        //视频填充方式
//        _avPlayer.playerLayer.videoGravity = AVLayerVideoGravityResize;
        
        [_avPlayer.toolView mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.height.mas_equalTo(30);
          make.top.mas_equalTo(self.view.frame.size.width-30);
          make.width.mas_equalTo(self.view.frame.size.height);

        }];
        
        
//        [self.view addSubview:_avPlayer];
        [[UIApplication sharedApplication].keyWindow addSubview:_avPlayer];
        
        _isFullScreen = YES;
        
        
        [UIView animateWithDuration:0.7 animations:^{

        _avPlayer.toolView.alpha = 0.6;
            
        }];
    }else{
    
    
        [_avPlayer removeFromSuperview];
        
        _avPlayer.toolView.alpha = 0;

        _avPlayer.transform = CGAffineTransformIdentity;
        _avPlayer.transform = CGAffineTransformMakeRotation(0);
        
//        [UIView animateWithDuration:0.5 animations:^{

        _avPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 9/16);
            
        _avPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.width * 9/16);
//        }];
        
        [_avPlayer.toolView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.bottom.equalTo(_avPlayer).offset(0);
            make.width.mas_equalTo(self.view.frame.size.width);
        }];
        
//        [self.view addSubview:_avPlayer];
        [[UIApplication sharedApplication].keyWindow addSubview:_avPlayer];
        
        _isFullScreen = NO;
        
        [UIView animateWithDuration:0.7 animations:^{
            
            _avPlayer.toolView.alpha = 0.6;
            
        }];
        

    }

}



- (void)addAVPlayer{


    
    
}



- (void)newFram{

  
   
  
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
