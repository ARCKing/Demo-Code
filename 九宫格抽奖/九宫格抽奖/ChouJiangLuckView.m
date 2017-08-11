//
//  ChouJiangLuckView.m
//  九宫格抽奖
//
//  Created by gxtc on 17/2/8.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ChouJiangLuckView.h"
#import <CoreGraphics/CoreGraphics.h>
#import "lbl_IntroPrizView.h"
#import "UILabel+Methods.h"
#import "AFNetworking.h"

//  屏幕宽高
#define WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 链接
#define GiftURL @"http://wz.lefei.com/App/mission/draw_data"
#define GiftNumber @"http://wz.lefei.com/App/mission/turntable"
#define GiftUserList @"http://wz.lefei.com/App/mission/draw_list"

// 颜色
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface giftModel()

@property(nonatomic,strong)NSString * id_;
@property(nonatomic,strong)NSString * name;


@end

@implementation giftModel


@end


typedef void(^giftDataBlock)(NSMutableArray *);
typedef void(^giftStarteBlock)(void);

@interface ChouJiangLuckView ()<CAAnimationDelegate>
{
    
        CGFloat           _width;
        CGFloat           _height;
        
        NSInteger         _row_line;
        NSMutableArray    *_btnTagArray;  // 存放btn的tag
        NSMutableArray    *_pointArray;   // 存放每个btn的坐标
        
        UIView               *_bgV;          // 遮罩层
        lbl_IntroPrizView    *_prizeIntroV;  // 奖项介绍
        
        UIImageView          *_bgImgv;    // 背景图
        
        UIImageView          *_scoreImgv; // 积分背景图
        UIImageView          *_coinImgv;  // 金币图
        UILabel              *_scoresl;   // 剩余积分
        BOOL                 _fromeOne;   // 是否从第一个开始抽奖
        BOOL                 _end;        // 转动是否要结束
    
        BOOL                 _middle;     // 中圈
        NSArray              *_selectValues;// 中奖Values
//        NSString             *_giftKeys;   //中奖Key
        NSString             *_number;     //抽奖次数
    
        NSInteger            _select;     // 选中的是第一个奖项
        NSInteger            _finialSec;  // 最后选中的那个
        
        NSTimer              *_timer;
        UIImageView          *_ninebgImgv;//九宫格背景图
    
        NSString             * _userUid;
        NSString             * _userToken;
        NSMutableDictionary  * _userinfo;
}

@property(nonatomic,strong)CALayer           *selectlayer;
@property(nonatomic,strong)NSMutableArray    *btnArray;     // 存放btn
@property(nonatomic,strong)UIButton          *readyb;    // 开始按钮

@property(nonatomic,strong)NSString          * endMessage;
@property(nonatomic,strong)NSArray * dataSourceArray;
@property(copy,nonatomic)giftDataBlock  giftDBc;
@property(copy,nonatomic)giftStarteBlock  giftStBc;
@property(copy,nonatomic)giftStarteBlock  giftChanceEnd;

@property(nonatomic,strong)NSMutableArray * giftIdArray;

/**
 *奖品 id name 
 */
@property(nonatomic,strong)NSString * gift_id;
@property(nonatomic,strong)NSString * gift_name;


/**中奖弹框提示*/
@property(nonatomic,strong)UIImageView * giftAleartView;
@property(nonatomic,strong)UILabel * giftAleartlabel;

@end

@implementation ChouJiangLuckView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
     
        [self createData];
        [self createUI];
        [self userUidAndToken];
    }
    return self;
}



- (void)getDataSource{
    [self giftDataGetFromNet];
    
    __weak ChouJiangLuckView * weakSelf = self;
    
    self.giftDBc = ^(NSMutableArray * dataSource){
        
        weakSelf.dataSourceArray = [NSArray arrayWithArray:dataSource];
        
        [weakSelf reloadDataSource];
    };
    
}

- (void)reloadDataSource{

    NSArray * btArray = [NSArray arrayWithArray:[self getBtFromArray]];
    
    NSLog(@"%d",(int)btArray.count);
    
    for (int i = 0 ; i < (int)btArray.count ; i++) {
        
        NSLog(@"%d",i);
        
        UIButton * bt = btArray[i];
        giftModel * model = self.dataSourceArray[i];
        [bt setTitle:model.name forState:UIControlStateNormal];
    }
    
     _scoresl.text = [NSString stringWithFormat:@"剩余抽奖次数:%@",_number];
}


- (NSArray *)getBtFromArray{

    NSLog(@"%@",_btnArray);
    
    UIButton * bt1 = _btnArray[0];
    UIButton * bt2 = _btnArray[1];
    UIButton * bt3 = _btnArray[2];
    UIButton * bt4 = _btnArray[4];
    UIButton * bt5 = _btnArray[7];
    UIButton * bt6 = _btnArray[6];
    UIButton * bt7 = _btnArray[5];
    UIButton * bt8 = _btnArray[3];

    return @[bt1,bt2,bt3,bt4,bt5,bt6,bt7,bt8];

}



- (void)userUidAndToken{

//    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
//    dict[@"token"] = dic[@"token"];
//    dict[@"uid"] = dic[@"uid"];
    
    dict[@"uid"] = @"30000002";
    dict[@"token"] = @"60e39694eeb1534d1f637447965bdb3e";
    _userinfo = [NSMutableDictionary dictionaryWithDictionary:dict];
}


/**
 奖品数据请求
 */
- (void)giftDataGetFromNet{
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    [manger POST:GiftURL parameters:_userinfo progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([code isEqualToString:@"1"]){
            
            NSMutableArray * dataArray = [NSMutableArray new];
            NSMutableArray * IDArray = [NSMutableArray new];

            NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
            NSString * number = [NSString stringWithFormat:@"%@",responseObject[@"number"]];
            
            if (number == nil || [number isEqual:[NSNull null]]) {
                number = @"0";
            }else{
                _number = number;
            }
            
            if (![responseObject[@"data"] isEqual:[NSNull null]] && responseObject[@"data" ] != nil) {
                
                NSArray * data = responseObject[@"data"];
                
                if ((int)data.count > 0) {
                    for (NSDictionary * dic in data) {
                        giftModel * model = [[giftModel alloc]init];
                        model.id_ = [NSString stringWithFormat:@"%@",dic[@"id"]];
                        model.name = [NSString stringWithFormat:@"%@",dic[@"name"]];
                        [dataArray addObject:model];
                        
                        //奖品id
                        [IDArray addObject:[NSString stringWithFormat:@"%@",dic[@"id"]]];
                    }
                    
                    self.giftIdArray = [NSMutableArray arrayWithArray:IDArray];
                }
            }
            self.giftDBc(dataArray);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark- 抽奖请求
/**
 抽奖
 */
- (void)GetGiftNumberFromNet{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    [manger POST:GiftNumber parameters:_userinfo progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([code isEqualToString:@"1"]){
            
            NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
            
            if (![responseObject[@"data"] isEqual:[NSNull null]] && responseObject[@"data" ] != nil) {
                
                NSDictionary * dic = responseObject[@"data"];
                self.gift_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
                self.gift_name = [NSString stringWithFormat:@"%@",dic[@"name"]];
                
                NSLog(@"中奖ID=%@\n 中奖金额=%@",self.gift_id,self.gift_name);
            }
            
            self.giftStBc();
        }else{
            
            NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
            self.endMessage = message;
            self.giftChanceEnd();
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];


}

#pragma mark- 中奖历史列表
/**
 *中奖列表
 */
- (void)getGiftListFromNet{
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    [manger POST:GiftUserList parameters:_userinfo progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)createData
{
    _btnTagArray = [NSMutableArray array];
    _pointArray = [NSMutableArray array];
    _btnArray = [NSMutableArray array];
    
    _fromeOne = YES;
}

- (void)createUI
{
    
    
    UIView * nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    nav.backgroundColor = [UIColor orangeColor];
    [self addSubview:nav];
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setTitle:@"<-" forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    bt.frame = CGRectMake(5, 25, 50, 30);
    [nav addSubview:bt];
    [bt addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    self.backBt = bt;
    
    UILabel * navTitle = [[UILabel alloc]init];
    navTitle.text = @"欢乐抽奖!";
    navTitle.textColor = [UIColor whiteColor];
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.frame = CGRectMake(WIDTH/4, 25, WIDTH/2, 30);
    [nav addSubview:navTitle];
    
    // 背景图
    _bgImgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    _bgImgv.image = [UIImage imageNamed:@"prizebg"];
    _bgImgv.userInteractionEnabled = YES;
    _bgImgv.backgroundColor = [UIColor greenColor];
    [self addSubview:_bgImgv];
    
//    // top
//    UIImageView *topImgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1039/3.0)];
//    topImgv.image = [UIImage imageNamed:@"top"];
//    topImgv.contentMode = UIViewContentModeScaleAspectFit;
//    topImgv.backgroundColor = [UIColor purpleColor];
//    [_bgImgv addSubview:topImgv];
    
   
    
    // 九宫格
    [self nineSquareView];
    
    // 剩余积分
    [self remainderScoreView];
}


- (void)backButton{
    NSLog(@"<-返回");

}

- (void)remainderScoreView
{
//    UIView *scorev = [[UIView alloc] initWithFrame:CGRectMake(0, 685/3.0, WIDTH, 105/3.0)];
//    scorev.backgroundColor = [UIColor redColor];
//    [_bgImgv addSubview:scorev];
//    
//    // 积分背景图
//    _scoreImgv = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-540/3.0)/2.0, 5, 540/3.0, 84/3.0)];
//    _scoreImgv.image = [UIImage imageNamed:@"scorebg"];
//    _scoreImgv.backgroundColor = [UIColor cyanColor];
//    [scorev addSubview:_scoreImgv];
//    
//    // 金币图
//    _coinImgv = [[UIImageView alloc] initWithFrame:CGRectMake(12, -8, 118/3.0, 105/3.0)];
//    _coinImgv.image = [UIImage imageNamed:@"coin"];
//    _coinImgv.backgroundColor = [UIColor yellowColor];
//    [_scoreImgv addSubview:_coinImgv];
    
    // 积分数
//    _scoresl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_coinImgv.frame)+7, -7, CGRectGetWidth(_scoreImgv.frame) - CGRectGetMaxX(_coinImgv.frame), 84/3.0)];
    _scoresl = [[UILabel alloc] init];
    _scoresl.frame = CGRectMake(0, 0, WIDTH, WIDTH/10);
    _scoresl.text = [NSString stringWithFormat:@"剩余抽奖次数:%d",0];
    _scoresl.textColor = [UIColor blackColor];
    _scoresl.textAlignment = NSTextAlignmentCenter;
//    [_scoresl fontStyle:@"4600" textColor:UIColorFromRGB(0xf9ed4d) textSize:35 fontName:nil fromRange:2];
    [_ninebgImgv addSubview:_scoresl];
//    [_scoresl sizeToFit];
    
    // 适配积分位置
//    [self fitScorePosition];
}

- (void)fitScorePosition
{
    _scoreImgv.frame = CGRectMake((WIDTH-(CGRectGetMaxX(_scoresl.frame)+15))/2.0, 5, CGRectGetMaxX(_scoresl.frame)+10, 84/3.0);
    _coinImgv.frame = CGRectMake(12, -8, 118/3.0, 105/3.0);
    _scoresl.frame = CGRectMake(CGRectGetMaxX(_coinImgv.frame)+7, -7, CGRectGetWidth(_scoreImgv.frame) - CGRectGetMaxX(_coinImgv.frame), 84/3.0);
}

#pragma mark- 九宫格
- (void)nineSquareView
{

    // 九宫格底图
    _ninebgImgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, HEIGHT -64-WIDTH, WIDTH, WIDTH)];
    _ninebgImgv.image = [UIImage imageNamed:@"sprize"];
    _ninebgImgv.userInteractionEnabled = YES;
    [_bgImgv addSubview:_ninebgImgv];
    
    _ninebgImgv.backgroundColor = [UIColor orangeColor];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(changebg)userInfo:nil repeats:YES];
    
    _width = WIDTH/4.0;
    _height = WIDTH/4.0;
    _row_line = 3;
    
    /**
     九宫格间隔
     */
    CGFloat space = 5.0;
    CGFloat leftDistance = (WIDTH - _width * 3 - 5*2)/2;
    CGFloat topheight = 0;
    CGFloat nine_top_distance = (WIDTH - _width * 3 - 5*2)/2;
    // 九宫格
    for (int i=0; i<_row_line*_row_line; i++)
    {
        if (i != 4)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(leftDistance+(_width+space)*(i%_row_line), nine_top_distance+(_height+space)*(i/_row_line), _width, _height);
            [btn setImage:[UIImage imageNamed:@"btnbg"] forState:UIControlStateNormal];
            [btn setTitle:@"--" forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor redColor];
            // 1.获取一共几个奖项
            // 2.给奖项分配位置
            
            btn.tag = i+1;
            [btn addTarget:self action:@selector(intro:) forControlEvents:UIControlEventTouchUpInside];
            [_ninebgImgv addSubview:btn];
            
            // 存放btn tag
            [_btnTagArray addObject:[NSNumber numberWithInteger:btn.tag]];
            // 存放每个btn的坐标
            NSValue *value = [NSValue valueWithCGPoint:btn.frame.origin];
            [_pointArray addObject:value];
            // 存放btn
            [_btnArray addObject:btn];
            
            // 记录btn的高度
            topheight = CGRectGetMaxY(btn.frame);
            
            // 中奖券
//            UIImageView *ticketImgv = [[UIImageView alloc] initWithFrame:CGRectMake((_width-216/3.0)/2.0, 44/3.0, 216/3.0, 117/3.0)];
//            ticketImgv.backgroundColor = [UIColor redColor];
//            [btn addSubview:ticketImgv];
            
//            // 文字描述
//            UILabel *ticketl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(ticketImgv.frame)+20/3.0, _width, 40/3.0)];
//            ticketl.text = @"";
//            ticketl.textColor = UIColorFromRGB(0x73353d);
//            ticketl.textAlignment = NSTextAlignmentCenter;
//            ticketl.font = [UIFont boldSystemFontOfSize:13];
//            [btn addSubview:ticketl];
            
            // 未中奖
        }
        else
        {
            
#pragma mark- 抽奖按钮
            // 开始按钮
            if (!_readyb)
            {
                _readyb = [UIButton buttonWithType:UIButtonTypeCustom];
                _readyb.frame = CGRectMake((CGRectGetWidth(_ninebgImgv.frame)-_width)/2.0, topheight-_height, _width, _height);
                [_readyb setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
                _readyb.backgroundColor = [UIColor blueColor];
                [_readyb addTarget:self action:@selector(startedAction) forControlEvents:UIControlEventTouchUpInside];
                _readyb.adjustsImageWhenHighlighted = NO;
                _readyb.layer.cornerRadius = _width/2;
                _readyb.clipsToBounds = YES;
                [_readyb setTitle:@"开始" forState:UIControlStateNormal];
            }
            [_ninebgImgv addSubview:_readyb];
        }
    }
    
    // 行走的框框
    if (!_selectlayer)
    {
        // 选中框
        _selectlayer = [CALayer layer];
        _selectlayer.backgroundColor = [UIColor yellowColor].CGColor;
        _selectlayer.frame = CGRectMake(leftDistance, nine_top_distance, _width, _height);
        _selectlayer.opacity = 0.6;
        _selectlayer.cornerRadius = 12;
        _selectlayer.hidden = YES;
    }
    [_ninebgImgv.layer addSublayer:_selectlayer];
    
    // 弹窗
//    if (!_bgV)
//    {
//        _bgV = [[UIView alloc] initWithFrame:self.bounds];
//        _bgV.backgroundColor = [UIColor blackColor];
//        _bgV.alpha = 0.0;
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeWindow)];
//        [_bgV addGestureRecognizer:tap];
//    }
//    [self addSubview:_bgV];
//    
//    // 奖品介绍
//    if (!_prizeIntroV)
//    {
//        _prizeIntroV = [[lbl_IntroPrizView alloc] initWithFrame:CGRectMake(100, 100, 200, 150)];
//        _prizeIntroV.backgroundColor = [UIColor greenColor];
//        _prizeIntroV.alpha = 0.0;
//        
//        __weak lbl_IntroPrizView *tempv1 = _prizeIntroV;
//        __weak UIView *tempv2 = _bgV;
//        _prizeIntroV.block = ^ {
//            
//            [UIView animateWithDuration:0.6 animations:^{
//                
//                tempv1.alpha = 0.0;
//                tempv2.alpha = 0.0;
//                
//            } completion:^(BOOL finished) {}];
//        };
//    }
//    [self addSubview:_prizeIntroV];
}

static int count;
// 背景闪烁
- (void)changebg
{
    count ++;
    if (count % 2 != 0) {
        _ninebgImgv.image = [UIImage imageNamed:@"sprize_1"];
    } else {
        _ninebgImgv.image = [UIImage imageNamed:@"sprize"];
    }
}

#pragma mark- 开始抽奖
// 开始
- (void)startedAction
{
    
    [self GetGiftNumberFromNet];
    
    __weak ChouJiangLuckView * weakSelf = self;
    
    self.giftStBc = ^{
    
        weakSelf.selectlayer.hidden = NO;
        weakSelf.readyb.enabled = NO;
        [weakSelf.readyb setImage:[UIImage imageNamed:@"grayStart"] forState:UIControlStateNormal];
        
        for (UIButton *btn in weakSelf.btnArray)
        {
            [btn setImage:[UIImage imageNamed:@"btnbg"] forState:UIControlStateNormal];
        }
        
        [weakSelf executeAnimation:1.0];
    };
    
    
    self.giftChanceEnd = ^{
    
        [weakSelf giftAleartViewShow:YES];
    };
   
}

// 介绍奖项
- (void)intro:(UIButton *)sender
{
    //    [UIView animateWithDuration:0.6 animations:^{
    //
    //        _bgV.alpha = 0.7;
    //        _prizeIntroV.alpha = 1;
    //
    //    } completion:^(BOOL finished) {
    //
    //    }];
    //
    //     _prizeIntroV.introText = @"这是一等奖";
}

// 抽奖动画
- (void)executeAnimation:(CGFloat)time
{
    // 加速动画
    
    // 1.创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    // 平移
    keyAnima.keyPath = @"position";
    // 1.1告诉系统要执行什么动画
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake([_pointArray[0] CGPointValue].x+_width/2.0,[_pointArray[0] CGPointValue].y+_height/2.0)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake([_pointArray[1] CGPointValue].x+_width/2.0,[_pointArray[1] CGPointValue].y+_height/2.0)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake([_pointArray[2] CGPointValue].x+_width/2.0,[_pointArray[2] CGPointValue].y+_height/2.0)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake([_pointArray[4] CGPointValue].x+_width/2.0,[_pointArray[4] CGPointValue].y+_height/2.0)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake([_pointArray[7] CGPointValue].x+_width/2.0,[_pointArray[7] CGPointValue].y+_height/2.0)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake([_pointArray[6] CGPointValue].x+_width/2.0,[_pointArray[6] CGPointValue].y+_height/2.0)];
    NSValue *value7 = [NSValue valueWithCGPoint:CGPointMake([_pointArray[5] CGPointValue].x+_width/2.0, [_pointArray[5] CGPointValue].y+_height/2.0)];
    NSValue *value8 = [NSValue valueWithCGPoint:CGPointMake([_pointArray[3] CGPointValue].x+_width/2.0, [_pointArray[3] CGPointValue].y+_height/2.0)];
    
//    if (_fromeOne) {
//        keyAnima.values = @[value1,value2,value3,value4,value5,value6,value7,value8];
//    } else {
        NSArray * values0 = @[value6,value7,value8,value1,value2,value3,value4,value5];
    
        NSArray * values1 = @[value6,value7,value8,value1];
        NSArray * values2 = @[value6,value7,value8,value1,value2];
        NSArray * values3 = @[value6,value7,value8,value1,value2,value3];
        NSArray * values4 = @[value6,value7,value8,value1,value2,value3,value4];
        NSArray * values5 = @[value6,value7,value8,value1,value2,value3,value4,value5];
        NSArray * values6 = @[value6,value7,value8,value1,value2,value3,value4,value5,value6];
        NSArray * values7 = @[value6,value7,value8,value1,value2,value3,value4,value5,value6,value7];
        NSArray * values8 = @[value6,value7,value8,value1,value2,value3,value4,value5,value6,value7,value8];

//    }
    
    keyAnima.values = values0;
    // 1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion = NO;
    // 1.3设置保存动画的最新状态
    keyAnima.fillMode = kCAFillModeForwards;
    // 1.4设置动画执行的圈数
    keyAnima.repeatCount = 2;
    // 1.5设置动画执行的时间
    keyAnima.duration = (time/(_row_line*_row_line*1.0-1))*keyAnima.values.count;
    keyAnima.repeatCount = 1;
    
    if (time == 1) {
        _middle = YES;
    } else if (time == 2) {
        _middle = NO;
    }else{
        /**
         *中奖设置
         */
        
        
        if ([self.gift_id isEqualToString:self.giftIdArray[0]]) {
            _selectValues = values1;

        }else if ([self.gift_id isEqualToString:self.giftIdArray[1]]){
            _selectValues = values2;

        }else if ([self.gift_id isEqualToString:self.giftIdArray[2]]){
            _selectValues = values3;

        }else if ([self.gift_id isEqualToString:self.giftIdArray[3]]){
            _selectValues = values4;

        }else if ([self.gift_id isEqualToString:self.giftIdArray[4]]){
            _selectValues = values5;

        }else if ([self.gift_id isEqualToString:self.giftIdArray[5]]){
            _selectValues = values6;

        }else if ([self.gift_id isEqualToString:self.giftIdArray[6]]){
            _selectValues = values7;

        }else if ([self.gift_id isEqualToString:self.giftIdArray[7]]){
            _selectValues = values8;
        }
    
        keyAnima.values = _selectValues;
        
        keyAnima.duration = [self selectResult:_selectValues];
        
        _end = YES;
    
    }

    // 1.6设置动画的节奏
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyAnima.calculationMode = kCAAnimationDiscrete;
    // 1.7设置代理，开始—结束
    keyAnima.delegate = self;
    // 2.0添加核心动画
    [_selectlayer addAnimation:keyAnima forKey:nil];
}

// 转到最后的的位置
- (float)selectResult:(NSArray *)arr
{

    if ((int)arr.count < 7) {
        return 2.5;
    }else if ((int)arr.count < 10){
        return 3.0;
    }else{
        return 3.5;
    }
}

// 关闭简介
- (void)closeWindow
{
    [UIView animateWithDuration:0.6 animations:^{
        
        _bgV.alpha = 0.0;
        _prizeIntroV.alpha = 0.0;
        
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - AnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    //    NSLog(@"开始动画");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 动画是否结束
    if (!_end) {
        
        if (_middle) {
            
            [self executeAnimation:2.0];
        }else{
            [self executeAnimation:3.0];
        }
    }
    else
    {
        _end = NO;
        
        _readyb.enabled = YES;
        [_readyb setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
        
        _selectlayer.hidden = YES;
        
        // 设置选中btn的背景
        UIButton *btn;
        
        if (_select < 3) {
            btn = (UIButton *)[self viewWithTag:[_btnTagArray[_select] intValue]];
        } else if (_select == 3) {
            btn = (UIButton *)[self viewWithTag:6];
        } else if (_select == 4) {
            btn = (UIButton *)[self viewWithTag:9];
        } else if (_select == 5) {
            btn = (UIButton *)[self viewWithTag:8];
        } else if (_select == 6) {
            btn = (UIButton *)[self viewWithTag:7];
        } else if (_select == 7) {
            btn = (UIButton *)[self viewWithTag:4];
        }
        [btn setImage:[UIImage imageNamed:@"yellowbtn"] forState:UIControlStateNormal];
        
        [self giftAleartViewShow:NO];
        
        [self giftDataGetFromNet];
    }
    
//    // 如果没有中奖则从谢谢参与开始转动
//    if (_select == 5) {
//        _fromeOne = NO;
//    }
}


- (void)giftAleartViewShow:(BOOL)end{

    if (self.giftAleartView == nil) {
        self.giftAleartView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/6, WIDTH/2, WIDTH*2/3, WIDTH/3)];
        self.giftAleartView.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.giftAleartView];
        self.giftAleartView.userInteractionEnabled = YES;
        
        self.giftAleartlabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, WIDTH*2/3, WIDTH/5)];
        self.giftAleartlabel.textColor = [UIColor blackColor];
        self.giftAleartlabel.textAlignment = NSTextAlignmentCenter;
        self.giftAleartlabel.numberOfLines = 0;
        [self.giftAleartView addSubview:self.giftAleartlabel];

        UIButton * hiddenBt = [UIButton buttonWithType:UIButtonTypeCustom];
        hiddenBt.backgroundColor = [UIColor redColor];
        [hiddenBt setTitle:@"确定" forState:UIControlStateNormal];
        hiddenBt.frame = CGRectMake(0, 0, WIDTH/5, WIDTH/15);
        hiddenBt.center = CGPointMake(WIDTH/3, WIDTH/3 - WIDTH/15);
        [hiddenBt addTarget:self action:@selector(giftAleartViewHidden) forControlEvents:UIControlEventTouchUpInside];
        [self.giftAleartView addSubview:hiddenBt];
        
    }

    if (end) {
        self.giftAleartlabel.text = [NSString stringWithFormat:@"%@",self.endMessage];

    }else{
        self.giftAleartlabel.text = [NSString stringWithFormat:@"恭喜你获得%@",self.gift_name];
    }
    self.giftAleartView.hidden = NO;
}


- (void)giftAleartViewHidden{
 
    self.giftAleartView.hidden = YES;
}

@end

