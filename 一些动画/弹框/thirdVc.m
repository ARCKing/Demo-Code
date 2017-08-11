//
//  thirdVc.m
//  弹框
//
//  Created by root on 16/10/28.
//  Copyright © 2016年 root. All rights reserved.
//

#import "thirdVc.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface thirdVc()
@property (nonatomic,strong) CAGradientLayer * gradientLayer;
@property (nonatomic,strong) UIBezierPath * bezierPath;
@property (nonatomic,strong) CAShapeLayer * shapeLayer;

@property (nonatomic,strong) CAGradientLayer * gradientLayer1;
@property (nonatomic,strong) UIBezierPath * bezierPath1;
@property (nonatomic,strong) CAShapeLayer * shapeLayer1;

@property (nonatomic,strong) CAGradientLayer * gradientLayer2;
@property (nonatomic,strong) UIBezierPath * bezierPath2;
@property (nonatomic,strong) CAShapeLayer * shapeLayer2;


@property (nonatomic,strong) CAGradientLayer * gradientLayer3;
@property (nonatomic,strong) UIBezierPath * bezierPath3;
@property (nonatomic,strong) CAShapeLayer * shapeLayer3;

@property (nonatomic,strong) CADisplayLink * link;
@property (nonatomic,strong)UILabel * labels;
@property (nonatomic,strong)UILabel * labels1;

@property (nonatomic,strong)UIView * vi1;
@property (nonatomic,strong)UIView * vi2;
@property (nonatomic,strong)UIView * vi3;
@property (nonatomic,strong)UIView * vi4;

@end

@implementation thirdVc

- (void)viewDidLoad{
    
    self.view.backgroundColor = [UIColor whiteColor];

//    [self circleCreat];
    [self colourCreat];
    [self creatProgress];
    [self creat0];
    [self creat7];

}


#pragma mark- 色带-颜色渐变
- (void)colourCreat{
    
    NSMutableArray * colorArray = [NSMutableArray new];
    
    for (NSInteger i = 0; i < 361; i++ ) {
                                           //颜色         //饱和度        //亮度
        UIColor * color  = [UIColor colorWithHue:i/360.0 saturation:1.0 brightness:1.0 alpha:1];
        
        [colorArray addObject:(__bridge id)color.CGColor];
    }
    
    
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = [NSArray arrayWithArray:colorArray];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    gradientLayer.frame = CGRectMake(0, 64, SCREEN_W, 50);
//    gradientLayer.position = self.view.center;
    
    [self.view.layer addSublayer:gradientLayer];
 
    CALayer * layer = [CALayer layer];
    layer.backgroundColor = [UIColor whiteColor].CGColor;
//    layer.frame = CGRectMake(0, 0, 100, 10);
    layer.position = self.view.center;
//    gradientLayer.mask = layer;
    layer.frame = CGRectMake(0, 0, 0, 10);

    self.gradientLayer = gradientLayer;
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 164, 100, 30)];
    label.text = @"汪汪汪！汪汪汪！";
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
//    label.center = self.view.center;
    
//    [self.view addSubview:label];
    
    
    CALayer * maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, 300, 200, 30);
    maskLayer.backgroundColor = [UIColor purpleColor].CGColor;
//    [self.view.layer addSublayer:maskLayer];
    
//    gradientLayer.mask = label.layer;
    
//    gradientLayer.mask = maskLayer;
    maskLayer.frame = CGRectMake(0, 0, 300, 30);
    
    label.frame = CGRectMake(0, 164, SCREEN_W, 30);
    
    
    CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(act)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}


- (void)act{
    
    NSMutableArray * arr = [NSMutableArray arrayWithArray:self.gradientLayer.colors];

    UIColor * col = [arr lastObject];
    
    [arr removeLastObject];
    
    [arr insertObject:col atIndex:0];
    
    self.gradientLayer.colors = [NSArray arrayWithArray:arr];
}



- (void)act2{

   static  CGFloat location = -0.01;
    
    
    self.gradientLayer.locations = @[@(location),@(location + 0.51),@(location + 0.81)];
    location += 0.01;
    
    if (location > 1) {
        location = 0;
    }
    
}


- (void)circleCreat{

    CAGradientLayer * grafientLayer = [CAGradientLayer layer];
    grafientLayer.frame = CGRectMake(0, 0, SCREEN_W/2, SCREEN_W/2);
    grafientLayer.position = self.view.center;
    grafientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor whiteColor].CGColor,
                             (__bridge id)[UIColor redColor].CGColor];
    
    grafientLayer.startPoint = CGPointMake(0, 0);
    grafientLayer.endPoint = CGPointMake(1, 0);
    grafientLayer.locations =  @[@0,@0.01,@0.6];
    [self.view.layer addSublayer:grafientLayer];


    
    CAShapeLayer * shapeLayer =[CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 5;
    
    
    UIBezierPath * beiZierPath = [UIBezierPath bezierPath];
    [beiZierPath addArcWithCenter:CGPointMake(SCREEN_W/4, SCREEN_W/4) radius:SCREEN_W/5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    shapeLayer.path = beiZierPath.CGPath;
    
//    grafientLayer.mask = shapeLayer;
    
    self.gradientLayer = grafientLayer;
    
    CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(act2)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
    
    
}

- (void)creatProgress{

    
    CALayer * layer = [CALayer layer];
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    layer.opacity = 0.1;
    layer.frame = CGRectMake(0, 0, SCREEN_W/3, SCREEN_W/3);
    layer.position = self.view.center;
    
    UIBezierPath * beiZierPath2 = [UIBezierPath bezierPath];
    [beiZierPath2 addArcWithCenter:CGPointMake(SCREEN_W/6, SCREEN_W/6) radius:SCREEN_W/7 startAngle:M_PI*3/4 endAngle:M_PI/4 clockwise:YES];
    
    CAShapeLayer * shapeLayer2 =[CAShapeLayer layer];
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer2.lineWidth = 5;
    shapeLayer2.path = beiZierPath2.CGPath;
    [layer addSublayer:shapeLayer2];
    
    [self.view.layer addSublayer:layer];
    
    CALayer * bgLayer = [CALayer layer];
    bgLayer.frame = CGRectMake(0, 0, SCREEN_W/3, SCREEN_W/3);
    bgLayer.position = self.view.center;
    bgLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:bgLayer];

    CAGradientLayer * gradirntLayer1 = [CAGradientLayer layer];
    gradirntLayer1.colors = @[(__bridge id)[UIColor blueColor].CGColor,
                              (__bridge id)[UIColor redColor].CGColor];

    gradirntLayer1.frame = CGRectMake(0, 0, SCREEN_W/6, SCREEN_W/6);
    gradirntLayer1.startPoint = CGPointMake(0, 0);
    gradirntLayer1.endPoint = CGPointMake(0,1);
    gradirntLayer1.locations =@[@0.1,@0.6];
    
    CAGradientLayer * gradirntLayer11 = [CAGradientLayer layer];
    gradirntLayer11.colors = @[(__bridge id)[UIColor blueColor].CGColor,
                              (__bridge id)[UIColor greenColor].CGColor];
    
    gradirntLayer11.frame = CGRectMake(SCREEN_W/6, 0, SCREEN_W/6, SCREEN_W/6);
    gradirntLayer11.startPoint = CGPointMake(0, 0);
    gradirntLayer11.endPoint = CGPointMake(0,1);
    gradirntLayer11.locations =@[@0.1,@0.6];

    [bgLayer addSublayer:gradirntLayer1];
    [bgLayer addSublayer:gradirntLayer11];
    
    
    
    CAShapeLayer * shapeLayer =[CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0;
    shapeLayer.lineCap = kCALineCapRound;
    
    UIBezierPath * beiZierPath = [UIBezierPath bezierPath];
    [beiZierPath addArcWithCenter:CGPointMake(SCREEN_W/6, SCREEN_W/6) radius:SCREEN_W/7 startAngle:M_PI*3/4 endAngle:M_PI/4 clockwise:YES];
    
    shapeLayer.path = beiZierPath.CGPath;
    bgLayer.mask = shapeLayer;

    
    self.shapeLayer = shapeLayer;
    
    CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(act3)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    self.link = link;
    
}


-(void)act3{

    
    if (self.shapeLayer.strokeEnd < 1 ) {

        self.shapeLayer.strokeEnd += 0.001;

    }else if(self.shapeLayer.strokeStart < 1){
    
        self.shapeLayer.strokeStart += 0.001;
    
    }else{
    
    
        self.shapeLayer.strokeStart = 0;
        self.shapeLayer.strokeEnd = -0.5;
        
    }
    
    
    
    
}



- (void)creat0{


    CALayer * layer0 = [CALayer layer];
    layer0.frame  = CGRectMake(10, SCREEN_H - SCREEN_W/3 - 49, SCREEN_W/3, SCREEN_W/3);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, SCREEN_W/3, SCREEN_W/3, 0);
    
    gradientLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];

    [layer0 addSublayer:gradientLayer];
    [self.view.layer addSublayer:layer0];
    
    self.gradientLayer1 = gradientLayer;
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(SCREEN_W/6, SCREEN_W/6) radius:SCREEN_W/6 -5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor greenColor].CGColor;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    
    shapeLayer.path = path.CGPath;
    layer0.mask = shapeLayer;
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/6, SCREEN_H - 59 - SCREEN_W/6, SCREEN_W/6, SCREEN_W/6)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
    label.text = @"0%";
    [self.view addSubview:label];
    self.labels = label;
    
    CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(act5)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)act5{

    static CGFloat  h = 0;
    static CGFloat  water = 0;

    
    if (water < SCREEN_W/3) {
        water += 0.1;
    }else{
    
        water = 0;
    }
    
    if (h < SCREEN_W/3) {
        h += 0.1;

    }else{
        
        h = 0;
    }
    
    self.labels.text = [NSString stringWithFormat:@"%.f",water/SCREEN_W*3.0 *100];
    self.gradientLayer1.frame = CGRectMake(0, SCREEN_W/3 - water, SCREEN_W/3, h);
}


- (void)testCreat{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor; //圆环底色
    layer.frame = CGRectMake(100, 100, 110, 110);
    
    
    //创建一个圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(55, 55) radius:50 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0.8;
    shapeLayer.lineCap = @"round";
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor redColor].CGColor,(id)[UIColor whiteColor].CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(50, 50, 60, 60);
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    [layer addSublayer:gradientLayer]; //设置颜色渐变
    [layer setMask:shapeLayer]; //设置圆环遮罩
    [self.view.layer addSublayer:layer];

}

//2d动画
- (void)creat6{

    UIView * view = [UIView new];
    view.frame = CGRectMake(20, SCREEN_H/2, SCREEN_W/5, 50);
    view.backgroundColor = [UIColor colorWithHue:168.0 saturation:1 brightness:1 alpha:1];
    [self.view addSubview:view];
    

    
    view.layer.position = view.frame.origin;
    
    view.layer.anchorPoint = CGPointMake(0, 0);
    
    [UIView animateWithDuration:2 animations:^{
       
        //旋转
        view.transform = CGAffineTransformMakeRotation(M_PI);
        
        //缩放
        view.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        //旋转与缩放一起，会旋转好多圈
        
        //位置变化
        view.transform = CGAffineTransformMakeTranslation(50, 50);
        
        //矩阵动画
        view.transform = CGAffineTransformMake(0, 0, 0, 0, 0,0 );
    }];
    
    
}


//基础动画 旋转，位移，缩放。。。
- (void)creat8{

    UIView * vi = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_W/2, SCREEN_W/5, SCREEN_W/5)];
    vi.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:vi];
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    animation.removedOnCompletion = YES;
    animation.repeatCount = HUGE_VAL;
    [vi.layer addAnimation:animation forKey:@"transform.rotation.z"];
    
    [animation beginTime];
}


- (void)creat9{
    UILabel * vi = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_W/2, SCREEN_W/5, SCREEN_W/5)];
    vi.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:vi];

    self.labels1 = vi;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self springAnimation];
    
    
}

//UIview专场动画
- (void)animation{

    CATransition * transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    transition.duration = 1;
    self.labels1.backgroundColor = [UIColor colorWithHue:arc4random()%361/360.0 saturation:1 brightness:1 alpha:1];
    [self.labels1.layer addAnimation:transition forKey:@""];

}

- (void)creat7{
    
    UIView * vi = [[UIView alloc]initWithFrame:CGRectMake(50, SCREEN_W/2, SCREEN_W/5, SCREEN_W/5)];
    vi.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:vi];
    self.vi1 = vi;


}

//弹簧效果动画
- (void)springAnimation{
    CASpringAnimation * springAnimation = [CASpringAnimation animationWithKeyPath:@"position"];
    springAnimation.duration = springAnimation.settlingDuration;
    springAnimation.mass = 50.0;
    springAnimation.initialVelocity = 5.0;
    springAnimation.damping = 100.0;
    springAnimation.stiffness = 5000.0;
    springAnimation.fillMode = kCAFillModeForwards;
    springAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
    springAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.vi1.layer addAnimation:springAnimation forKey:@"sp"];
}

@end
