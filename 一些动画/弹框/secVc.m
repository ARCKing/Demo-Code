//
//  secVc.m
//  弹框
//
//  Created by root on 16/10/28.
//  Copyright © 2016年 root. All rights reserved.
//

#import "secVc.h"
#import "nextVc.h"
#import "viewBeizier.h"
@interface secVc()

@property(nonatomic,strong)CAShapeLayer * shapeLayer;
@property(nonatomic,strong)CAShapeLayer * shapeLayer1;
@property(nonatomic,strong)CAShapeLayer * shapeLayer2;
@property(nonatomic,strong)CAShapeLayer * shapeLayer3;

@property(nonatomic,strong)UIBezierPath * beizierPath;

@property(nonatomic,strong)viewBeizier * viewBeiZer;

@property(nonatomic,assign)NSInteger ww;


@property(nonatomic,assign)CGFloat waveA;//水纹振幅    表示上面的A
@property(nonatomic,assign)CGFloat waveW ;//水纹周期  表示上面的ω
@property(nonatomic,assign)CGFloat offsetX; //位移   表示上面的φ
@property(nonatomic,assign)CGFloat currentK; //当前波浪高度Y   表示上面的C
@property(nonatomic,assign)CGFloat waveSpeed;//水纹速度   表示波浪流动的速度
@property(nonatomic,assign)CGFloat waterWaveWidth; //水纹宽度



@end

@implementation secVc

- (void)viewDidLoad{

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self creat4];

    [self creat2];

    [self creatWare];

}


#pragma mark- 绘线
- (void)creat0{

    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];

    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];

    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.lineWidth = 5;
    
    //变成线段
    shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:20], [NSNumber numberWithInt:10], nil];
    
    shapeLayer.lineDashPhase = 15;
    
    //线段转角
    shapeLayer.lineJoin = kCALineJoinRound;

    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
}


- (void)creat1{

    

}

#pragma mark- 旋转动画 - Z轴
- (void)creat2{
    
    UIView * cube = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    cube.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:cube];
    
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    basicAnimation.toValue = [NSNumber numberWithFloat:-M_PI*2];
    basicAnimation.duration = 5;
//    basicAnimation.autoreverses = YES;
    basicAnimation.repeatCount = HUGE_VALF;

    [cube.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
    
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    UIBezierPath * beizierPath = [UIBezierPath bezierPath];
    
    [beizierPath addArcWithCenter:CGPointMake(25, 25) radius:15 startAngle:0 endAngle:M_PI*2/3 clockwise:YES];
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 2;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = beizierPath.CGPath;
    
    [cube.layer addSublayer:shapeLayer];
    
    
    CAShapeLayer * shapeLayer1 = [CAShapeLayer layer];
    
    //初始时路径
    UIBezierPath * beizierPath1 = [UIBezierPath bezierPath];
    shapeLayer1.lineCap = kCALineCapRound;
    [beizierPath1 moveToPoint:CGPointMake(30, 30)];
    [beizierPath1 addLineToPoint:CGPointMake(40, 25)];
    [beizierPath1 addLineToPoint:CGPointMake(45, 35)];

    //结束时路劲
    UIBezierPath * beizierEndPath = [UIBezierPath bezierPath];
    [beizierEndPath moveToPoint:CGPointMake(30, 15)];
    [beizierEndPath addLineToPoint:CGPointMake(40, 25)];
    [beizierEndPath addLineToPoint:CGPointMake(45, 15)];
    
    
    //中间路劲
    UIBezierPath * beizierMiddlePath = [UIBezierPath bezierPath];
    [beizierMiddlePath moveToPoint:CGPointMake(30, 20)];
    [beizierMiddlePath addLineToPoint:CGPointMake(40, 25)];
    [beizierMiddlePath addLineToPoint:CGPointMake(50, 20)];
    
    
    
    shapeLayer1.fillColor = nil;
    shapeLayer1.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer1.lineWidth = 2;
    shapeLayer1.path = beizierPath1.CGPath;
    
    [cube.layer addSublayer:shapeLayer1];
    
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(50, 150, 50, 50);
    replicatorLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    [replicatorLayer addSublayer:cube.layer];
    
    replicatorLayer.instanceCount = 2;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    
    
    
    
    
    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];

    //路径
    keyFrameAnimation.values = @[(__bridge id)beizierPath1.CGPath,(__bridge id)beizierEndPath.CGPath,(__bridge id)beizierMiddlePath.CGPath,(__bridge id)beizierMiddlePath.CGPath];
    
    NSNumber * number1 = [NSNumber numberWithFloat:0.2];
    NSNumber * number2 = [NSNumber numberWithFloat:0.6];
    NSNumber * number3 = [NSNumber numberWithFloat:0.9];
    NSNumber * number4 = [NSNumber numberWithFloat:0.95];

    //keyTimes中的每一个时间值都对应values中的每一帧.当keyTimes没有设置的时候,各个关键帧的时间是平分的
    keyFrameAnimation.keyTimes = @[number1,number2,number3,number4];
    keyFrameAnimation.autoreverses = YES;
    keyFrameAnimation.duration = 1;
    keyFrameAnimation.repeatCount = HUGE_VAL;
    
    [shapeLayer1 addAnimation:keyFrameAnimation forKey:@"path"];
    
    [self.view.layer addSublayer:replicatorLayer];
}


#pragma mark- 关键帧动画2-values
- (void)creat3{
    UIView * cube = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 50, 50)];
    cube.backgroundColor = [UIColor redColor];
    [self.view addSubview:cube];

    
    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue * key1 = [NSValue valueWithCGPoint:CGPointMake(50, 100)];
    NSValue * key2 = [NSValue valueWithCGPoint:CGPointMake(100, 150)];
    NSValue * key3 = [NSValue valueWithCGPoint:CGPointMake(150, 250)];
    NSValue * key4 = [NSValue valueWithCGPoint:CGPointMake(300, 350)];

    NSArray * arr = [NSArray arrayWithObjects:key1,key2,key3,key4, nil];
    
    keyFrameAnimation.values = arr;
    
    keyFrameAnimation.duration = 2;
    keyFrameAnimation.repeatCount = HUGE_VALF;
    keyFrameAnimation.autoreverses = YES;
    [cube.layer addAnimation:keyFrameAnimation forKey:@"GGKeyframeAnimation"];
}





#pragma mark- 波浪效果
// 只跟相位有关
- (void)creat4{
    
    CGFloat W = CGRectGetWidth(self.view.bounds);
    CGFloat H = CGRectGetHeight(self.view.bounds);
    
    //公式:ω = 2π/T
    //设置波的宽度是容器的宽度，希望能展示0.5个波曲线，周期为T=W/0.5;
    //ω = 2π/T -> π/W
    
    CGFloat w = M_PI/W;
    
    if(self.shapeLayer == nil){
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor colorWithRed:211/255.0 green:10/255.0 blue:15/255.0 alpha:1].CGColor;
        [self.view.layer addSublayer:layer];
        
        self.shapeLayer = layer;
    }
    
    //振幅
    self.waveA = 20;
    //ω常量
    self.waveW = w;
    //y轴偏移
    self.currentK = H/2;
    //相位
    self.waveSpeed = 0.05;
    [self displayLinkStar];
}

#pragma mark- CADisplayLink计时器
//每一帧刷新一次，比 NSTimer 准确
- (void)displayLinkStar{
    CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

#pragma mark- 绘制波浪
- (void)waveAnimation{
    
    self.offsetX += self.waveSpeed;
    
    CGFloat W = CGRectGetWidth(self.view.bounds);
    CGFloat H = CGRectGetHeight(self.view.bounds);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = self.currentK;
    
    CGPathMoveToPoint(path, nil, 0, y);
    
    for (NSInteger x = 0; x <= W; x++) {
        
        
        y = self.waveA * sinf(self.waveW*x + self.offsetX) + _currentK;
        
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    
    CGPathAddLineToPoint(path, nil,W, H*2/3);
    CGPathAddLineToPoint(path, nil, 0, H*2/3);
    //    self.shapeLayer.fillColor = [UIColor redColor].CGColor;
    CGPathCloseSubpath(path);
    
    self.shapeLayer.path = path;
    
    CGPathRelease(path);
}



#pragma mark- 关键帧动画-三次贝塞尔曲线-path
- (void)creat5{

    UIView * cube = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 50, 50)];
    cube.backgroundColor = [UIColor redColor];
    [self.view addSubview:cube];

    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 100, 100);//起点
    CGPathAddCurveToPoint(path, NULL, 150,150,250,250, 350, 350);
    keyFrameAnimation.path = path;
    
    CGPathRelease(path);
    
    keyFrameAnimation.duration = 2;
    keyFrameAnimation.repeatCount = HUGE_VALF;
    
    [cube.layer addAnimation:keyFrameAnimation forKey:@"GGKeyframeAnimation"];
}



- (void)creatRound{

    self.shapeLayer = [CAShapeLayer new];
    self.shapeLayer.frame = CGRectMake(0, 0, 100, 100);
    self.shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    self.shapeLayer.lineWidth = 5.0f;
    self.shapeLayer.position = self.view.center;
    
    self.beizierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    
    
    self.shapeLayer.path = self.beizierPath.CGPath;
    self.shapeLayer.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.shapeLayer];
    
    
   
}


- (void)timerStar{

    NSTimer * myTime = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(waveAnimation) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:myTime forMode:NSRunLoopCommonModes];

}


#pragma mark- 波纹
- (void)creatWare{

    CALayer * layer = [CALayer layer];
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.frame = CGRectMake(0, 0, 150, 150);
//    [self.view.layer addSublayer:layer];
    
    CALayer * layer1 = [CALayer layer];
    layer1.backgroundColor = [UIColor redColor].CGColor;
    layer1.frame = CGRectMake(0, 0, 30, 30);
    layer1.position = CGPointMake(75, 75);
    layer1.cornerRadius = 15;
    [layer addSublayer:layer1];

//    CAShapeLayer * shaperLayer = [CAShapeLayer layer];
//    shaperLayer.fillColor = [UIColor clearColor].CGColor;
//    shaperLayer.strokeColor = [UIColor redColor].CGColor;
//
//    UIBezierPath * beizierPath = [UIBezierPath bezierPath];
//    [beizierPath addArcWithCenter:CGPointMake(75, 75) radius:30 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    shaperLayer.path = beizierPath.CGPath;
//    
//    [layer addSublayer:shaperLayer];
    
    
    CAReplicatorLayer * replicationrLayer = [CAReplicatorLayer layer];
    replicationrLayer.frame = CGRectMake(150, 200, 150, 150);
    replicationrLayer.instanceCount = 3;
    replicationrLayer.instanceDelay = 1;
    [replicationrLayer addSublayer:layer];
//    replicationrLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.duration = 3;
    basicAnimation.repeatCount = HUGE_VAL;
    basicAnimation.fromValue = @1;
    basicAnimation.toValue = @5;
    [layer addAnimation:basicAnimation forKey:@"transform.scale"];
    

    CABasicAnimation * basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation1.duration = 3;
    basicAnimation1.repeatCount = HUGE_VAL;
    basicAnimation1.fromValue = @1;
    basicAnimation1.toValue = @0;
    [layer addAnimation:basicAnimation1 forKey:@"opacity"];

    [self.view.layer addSublayer:replicationrLayer];
}



@end
