//
//  ViewController.m
//  player
//
//  Created by gxtc on 16/9/12.
//  Copyright © 2016年 gxtc. All rights reserved.
//


#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MyPlayer.h"
#import "PlayerCell.h"
#define Screen_W self.view.bounds.size.width
#define Screen_H self.view.bounds.size.height

#define MP4URL1 @"http://v1.mukewang.com/d88f32c5-3e66-44ab-ab7b-0f0383edfba8/L.mp4"
#define MP4URL2 @"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)AVPlayer * player;
@property(nonatomic,assign)NSInteger state;
@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)UILabel * timeLabel;

@property(nonatomic,strong)UIView * bgImageView;
@property(nonatomic,strong)UIView * toolView;


@property(nonatomic,strong)UIProgressView * progressView;

@property(nonatomic,strong)UISlider * progressSlider;

@property(nonatomic,strong)UIButton * buttonOfStar;


@property(nonatomic,strong)PlayerCell * cell;
@property(nonatomic,strong)MyPlayer * myPlayer;

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,retain)NSArray * urlArray;

@property(nonatomic,retain)NSIndexPath * curretnIndex;

@property(nonatomic,assign)NSInteger oldCGRect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.state = 1;
    
//    [self addBgImageView];
    
    _urlArray = @[MP4URL1,MP4URL2,MP4URL1,MP4URL2,MP4URL1,MP4URL2,MP4URL1,MP4URL2];
    
    self.tableView = [self tableView];
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen_W, Screen_H - 64) style:UITableViewStylePlain];
        
        _tableView.rowHeight = Screen_W * 9 / 16;
        _tableView.cellLayoutMarginsFollowReadableWidth = YES;
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 8;

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSLog(@"滑滑滑滑滑滑！！！");
    NSLog(@"%f",self.tableView.contentOffset.y);
    NSLog(@"%f",scrollView.contentOffset.y);
    
    if (_curretnIndex) {
        PlayerCell * cell = [self.tableView cellForRowAtIndexPath:_curretnIndex];
        
        NSLog(@"%ld",cell.tag);
        
        if (_oldCGRect < scrollView.contentOffset.y) {
            _oldCGRect = scrollView.contentOffset.y;
            NSLog(@"上滑");

            if (cell.tag == 0 && _oldCGRect > Screen_W *9/16) {

                NSLog(@"[[[[消失]]]]");
                [self releaseAVPlayer];
            }
            
        }else if (_oldCGRect > scrollView.contentOffset.y) {
            
            _oldCGRect = scrollView.contentOffset.y;
            NSLog(@"下滑");
            if (cell.tag == 0 && _oldCGRect > Screen_W *9/16) {
                NSLog(@"===消失====");
                [self releaseAVPlayer];
            }
        }

    }
    
    
    

}

#pragma mark- 销毁AVPlayer
- (void)releaseAVPlayer{
    [_myPlayer.player.currentItem cancelPendingSeeks];
    [_myPlayer.player.currentItem.asset cancelLoading];
    [_myPlayer.player pause];
    [_myPlayer removeFromSuperview];
    [_myPlayer.playerLayer removeFromSuperlayer];
    [_myPlayer.player replaceCurrentItemWithPlayerItem:nil];
    
    _curretnIndex = nil;
    
    _myPlayer = nil;
    _myPlayer.player = nil;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    _cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_%ld",indexPath.row]];
    
    if (_cell == nil) {
        _cell = [[PlayerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell_%ld",indexPath.row]];
        _cell.tag = indexPath.row;
        NSLog(@"%ld",_cell.tag);
    }
    
    _cell.videoUrl = _urlArray[indexPath.row];
    
    [_cell.playButton addTarget:self action:@selector(playAndStop::) forControlEvents:UIControlEventTouchUpInside];
    
    if (_curretnIndex == indexPath) {
        
        [_cell.playButton.superview sendSubviewToBack:_cell.playButton];
    }else {
    
        [_cell.playButton.superview bringSubviewToFront:_cell.playButton];
    
    }
    
    
    
    
    
    return _cell;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
}

- ( void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    
    NSLog(@"新选择了=%ld",indexPath.row);


}


- (void)playAndStop:(UIButton *)button :(id)event{
   
    //获取Button所在的Cell;
    
//    PlayerCell *cell = (PlayerCell *)button.superview.superview;
    
    //获取Button所在的Cell;
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_tableView];
    NSIndexPath *path= [_tableView indexPathForRowAtPoint:currentTouchPosition];
    PlayerCell * cell = (PlayerCell *)[self.tableView cellForRowAtIndexPath:path];
    
    _curretnIndex = path;
    
    if (_myPlayer) {
        [_myPlayer removeFromSuperview];
        [_myPlayer getNewPlayerIteamWithUrl:cell.videoUrl];
        
    }else {
    
        _myPlayer =[[MyPlayer alloc]initPlaverWithURL:cell.videoUrl andFram:CGRectMake(0, 0, Screen_W, Screen_W*9/16)];

    
    }
    
   
    [cell.bgImageView addSubview:_myPlayer];
    
    [cell.bgImageView bringSubviewToFront:_myPlayer];
    
    [cell.playButton.superview sendSubviewToBack:cell.playButton];

    NSLog(@"come!!!!!!!!");
    
    [self.tableView reloadData];

}



@end

