//
//  fourVc.m
//  弹框
//
//  Created by root on 16/10/28.
//  Copyright © 2016年 root. All rights reserved.
//

#import "fourVc.h"
#import "wkWebViewController.h"
#import "collection_Cell.h"
#import "collection_TwoCell.h"
#import "fourView.h"
#import "FViewController.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface fourVc()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,CAAnimationDelegate>

@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * muArray;

@property (nonatomic,strong)CAShapeLayer * shaper1;
@property (nonatomic,strong)CAShapeLayer * shaper2;
@property (nonatomic,strong)CAShapeLayer * shaper3;
@property (nonatomic,strong)CAShapeLayer * shaper4;

@end

@implementation fourVc
- (void)viewDidLoad{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(122, 220, 100, 100);
    
    button.backgroundColor =[UIColor redColor];
    
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:button];
    
//    [self collectionViewCreat];
    
//    [self creatRadar];
    
//    [self creatText0];
//    [self creatText1];
//    [self creatText2];
//    [self creatText3];
//    [self creatText4];
    [self creatText7];
    [self creatText9];
    [self creat8];
    [self creatText10];


    [self creatButton];
}


#pragma mark-CGcontextRef
- (void)creatRadar{
    
    //获取画布
    UIGraphicsBeginImageContext(self.view.bounds.size);


    //获取绘图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //笔画线颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    //填充颜色
    CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
    
    //比画线宽度
    CGContextSetLineWidth(ctx, 2.0);
    
    CGContextAddRect(ctx, CGRectMake(10, 100, 50, 50));
    
    //绘制路劲加填充
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //绘制路劲
//    CGContextStrokePath(ctx);


    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    
    [self.view addSubview:imageView];
    
}


//绘制弧线
- (void)creatText0{
    UIGraphicsBeginImageContext(self.view.bounds.size);

    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(ref, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(ref, [UIColor orangeColor].CGColor);
    
    //弧线从起点出发，与直线1（p1,p2）,直线2（p2,p3）相切
    CGContextMoveToPoint(ref, 50, 200);//p1点（起点）
                                //p2点      p3点    半径
    CGContextAddArcToPoint(ref, 100, 100, 150, 150, 50);

    CGContextDrawPath(ref, kCGPathFillStroke);

    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView * iv = [[UIImageView alloc]initWithImage:image];
    
    [self.view addSubview:iv];

}

#pragma mark- 绘制一条线
- (void)creatText1{

    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(ref, [UIColor yellowColor].CGColor);
    CGContextSetFillColorWithColor(ref, [UIColor purpleColor].CGColor);
    CGContextAddArc(ref, 200, 200, 50, 0, M_PI, 1);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, 200, 150);
    CGPathAddLineToPoint(path, nil, 200, 200);
    
    CGContextAddPath(ref,path);
    
    CGContextDrawPath(ref, kCGPathFillStroke);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView * imagev =[[UIImageView alloc]initWithImage:image];
    
    [self.view addSubview:imagev];
    
}


#pragma mark- 多个矩形绘制
- (void)creatText2{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef ref1 = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ref1, [UIColor orangeColor].CGColor);
    CGContextSetFillColorWithColor(ref1, [UIColor purpleColor].CGColor);
    
//    矩形数组
    CGRect rects[10];
    
    for (int i = 0; i < 10; i++) {
        
        rects[i] = CGRectMake(i*5, 200 +(i+ 0)*10, i+20, 10*(i+0));
    }
    
    CGContextAddRects(ref1, rects, 10);
    
    //许多点绘制【同理】
//    CGContextAddLines(ref1, <#const CGPoint * _Nullable points#>, <#size_t count#>)
    
    
    //填充不重叠的路径颜色
    CGContextDrawPath(ref1, kCGPathEOFill);
    //填充路劲颜色
    CGContextDrawPath(ref1, kCGPathFill);
    //绘制边框
    CGContextDrawPath(ref1, kCGPathStroke);
    //边框+填充
    CGContextDrawPath(ref1, kCGPathFillStroke);
    //填充不重叠的路径颜色+边框
    CGContextDrawPath(ref1, kCGPathEOFillStroke);

    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView * imagev =[[UIImageView alloc]initWithImage:img];
    
    [self.view addSubview:imagev];
    
}

#pragma mark- 色彩空间
- (void)creatText3{

    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(ref, [UIColor redColor].CGColor);
    
    CGColorSpaceRef csr = CGColorSpaceCreateDeviceRGB();
    
    CGFloat f[3];
    f[0] = 123.0/255.0;
    f[1] = 163.0/255.0;
    f[2] = 12.0/255.0;

    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(csr, f, nil, 3);
    
    CGColorSpaceRelease(csr);
    
//    CGContextDrawLinearGradient(ref, gradientRef, CGPointMake(100, 64), CGPointMake(100, 500), kCGGradientDrawsBeforeStartLocation);
  
    CGContextDrawRadialGradient(ref, gradientRef, CGPointMake(150, 150), 0.0, CGPointMake(150, 350), 50.0, kCGGradientDrawsAfterEndLocation);
    
    
    
    CGContextSetStrokeColorSpace(ref, csr);
    CGContextDrawPath(ref,kCGPathFillStroke);
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView * imagev =[[UIImageView alloc]initWithImage:img];
    
    [self.view addSubview:imagev];

}


- (void)creatText4{


    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(ref, [UIColor grayColor].CGColor);
    
    
    CGFloat f[1];
    f[0] = 123.0/255.0;
    
    CGFloat ff[5];
    ff[0] = 120.0/255.0;
    ff[1] = 220.0/255.0;
    ff[2] = 10.0/255.0;
    ff[3] = 190.0/255.0;
    ff[4] = 20.0/255.0;

    CGContextSetStrokeColor(ref, f);
    CGContextSetFillColor(ref, ff);
    
    CGContextMoveToPoint(ref, 64, 64);
    CGContextAddCurveToPoint(ref, 130, 130, 120, 120, 10, 260);
    
    CGContextDrawPath(ref, kCGPathFillStroke);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageView * vi = [[UIImageView alloc]initWithImage:image];
    
    [self.view addSubview:vi];
    
    
}


- (void)creatText5{

    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(ref, [UIColor orangeColor].CGColor);
    
    CGContextMoveToPoint(ref, 50, 150);
    CGContextAddLineToPoint(ref, 200, 300);
    
    CGFloat length[] = {5,20};
    
    CGContextSetLineDash(ref, 1, length, 2);
    
    CGContextDrawPath(ref, kCGPathStroke);
    
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    UIImageView * view = [[UIImageView alloc]initWithImage:image];
    
    [self.view addSubview:view];


    
    
}



- (void)creatButton{

    self.muArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 5; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0,0, 20, 20);
        button.layer.cornerRadius = 10;
        button.center = CGPointMake(20 + (50 + 20)*i, SCREEN_H - 49);
        button.clipsToBounds = YES;
        button.backgroundColor = [UIColor colorWithHue:arc4random()%361/361.0 saturation:1 brightness:1 alpha:1 ];
        [self.muArray addObject:button];
        [self.view addSubview:button];
    }


}



- (void)buttonAction{
    
    for (int i = 0;i < 5;i++) {
        UIButton * bt = self.muArray[i];
        
        [self addSpring:bt andDelayTime:0.05*i];
    }
}



- (void)addSpring:(UIButton *)bt andDelayTime:(NSTimeInterval)time{

    //持续时间   //延时   //阻尼系数（0.0f~1.0f）[越小，震动效果越明显]        //初速        //动画属性
    [UIView animateWithDuration:2 delay:time usingSpringWithDamping:0.4f initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        bt.center = CGPointMake(bt.center.x, bt.center.y -100);
        
        
        //只放大5倍
        bt.transform = CGAffineTransformMakeScale(5, 5);
        
        //在放大的基础上再放大5倍
//        bt.transform = CGAffineTransformScale(bt.transform, 5, 5);
        
    } completion:^(BOOL finished) {
        
    }];

}



- (void)creatText6{
    
    UIView * vi = [[UIView alloc]initWithFrame:CGRectMake(10, 164, 50, 50)];
    vi.backgroundColor =[UIColor redColor];
    [self.view addSubview:vi];
    CABasicAnimation * an = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    an.duration = 1;
    an.repeatCount = HUGE_VAL;
    an.autoreverses = YES;
    an.toValue = @[@2];
    [vi.layer addAnimation:an forKey:@"transform.scale"];
    
    
    CGAffineTransform  transform = CGAffineTransformIdentity;

//CGAffineTransformMake(<#CGFloat a#>, <#CGFloat b#>, <#CGFloat c#>, <#CGFloat d#>, <#CGFloat tx#>, <#CGFloat ty#>)
    
}



- (void)creatText7{

    
    NSArray * colours = [NSArray arrayWithArray:[self getColoures]];
    
    UIColor * colour0 = [UIColor new];
    UIColor * colour1 = [UIColor new];
    UIColor * colour2 = [UIColor new];
    UIColor * colour3 = [UIColor new];

    
#pragma mark- gradientlayer 与 gradientlayer 之间颜色过渡
    colour0 = colours[0];
    colour1 = colours[1];
    colour2 = colours[2];
    colour3 = colours[3];
    
    
    CALayer * layer0 = [CALayer layer];
    layer0.frame = CGRectMake(20, 150, 150, 150);
    [self.view.layer addSublayer:layer0];
    
    CALayer * layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0, 0, 150, 150);
    [layer0 addSublayer:layer1];


#pragma mark-4个gradientlayer颜色渐变
    CAGradientLayer * gradientlayer1 = [CAGradientLayer layer];
    gradientlayer1.frame = CGRectMake(0, 0, 75, 75);
    
    gradientlayer1.colors = @[(__bridge id)colour0.CGColor,
                              (__bridge id)colour1.CGColor];
    
    gradientlayer1.startPoint = CGPointMake(1, 0);
    gradientlayer1.endPoint = CGPointMake(0, 1);
    
    
    CAGradientLayer * gradientlayer2 = [CAGradientLayer layer];
    gradientlayer2.frame = CGRectMake(0, 75, 75, 75);
    
    gradientlayer2.colors = @[(__bridge id)colour1.CGColor,
                              (__bridge id)colour2.CGColor];

    gradientlayer2.startPoint = CGPointMake(0, 0);
    gradientlayer2.endPoint = CGPointMake(1,1);
    
    CAGradientLayer * gradientlayer3 = [CAGradientLayer layer];
    gradientlayer3.frame = CGRectMake(75, 75, 75, 75);
    
    gradientlayer3.colors = @[(__bridge id)colour2.CGColor,
                              (__bridge id)colour3.CGColor];
    
    gradientlayer3.startPoint = CGPointMake(0, 1);
    gradientlayer3.endPoint = CGPointMake(1, 0);

    CAGradientLayer * gradientlayer4 = [CAGradientLayer layer];
    gradientlayer4.frame = CGRectMake(75, 0, 75, 75);
    
    gradientlayer4.colors = @[(__bridge id)colour3.CGColor,
                              (__bridge id)[UIColor whiteColor].CGColor];
    
    gradientlayer4.startPoint = CGPointMake(1, 1);
    gradientlayer4.endPoint = CGPointMake(0, 0);

    [layer1 addSublayer:gradientlayer1];
    [layer1 addSublayer:gradientlayer2];
    [layer1 addSublayer:gradientlayer3];
    [layer1 addSublayer:gradientlayer4];

    
#pragma mark- 把下面代码注释掉，就可以看到4个人gradientlayer颜色过渡效果
    
    //路径
    UIBezierPath * beizierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(75, 75) radius:70 startAngle: -M_PI/2 endAngle:M_PI*2 -M_PI/2 clockwise:YES];
    CAShapeLayer * shaperLayer = [CAShapeLayer layer];
    shaperLayer.lineCap = kCALineCapRound;
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    shaperLayer.strokeColor = [UIColor redColor].CGColor;
    shaperLayer.lineWidth = 5.0;
    shaperLayer.strokeStart = 0.01;
    shaperLayer.strokeEnd = 0.99;
    shaperLayer.path = beizierPath.CGPath;
    layer1.mask = shaperLayer;
    
    
    //添加动画
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.duration = 1;
    basicAnimation.fromValue = @0.0;
    basicAnimation.toValue = @(M_PI*2);
    basicAnimation.repeatCount = HUGE_VAL;
    
    [layer0 addAnimation:basicAnimation forKey:@"transform.rotation.z"];
}

#pragma mark- 获取颜色
- (NSArray *)getColoures{
    
    NSMutableArray * array = [NSMutableArray new];
    
    UIColor * redcolour = [UIColor colorWithHue:136.0 saturation:1.0 brightness:1.0 alpha:1];

    //同一种颜色的不同饱和度（这里取4种）
    for (int i = 0; i < 4; i++) {
        
        CGFloat hue = 0.0;

        CGFloat saturation = 0.0;
        
        CGFloat brightness = 0.0;
        
        CGFloat alpha = 0.0;

        
        [redcolour getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        UIColor * newColour = [UIColor colorWithHue:hue saturation: saturation - (i*0.25) brightness:brightness alpha:alpha];
        
        NSLog(@"%f,%f,%f,%f",hue,saturation,brightness,alpha);

        [array addObject:newColour];
    }
    
    return array;
}



- (void)creat8{


    
    
    CALayer * layer0 = [CALayer layer];
    layer0.backgroundColor = [UIColor orangeColor].CGColor;
    layer0.cornerRadius = 15;
    layer0.frame = CGRectMake(190, 150, 150, 150);
    [self.view.layer addSublayer:layer0];
    
    CALayer * layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0, 0, 150, 150);
    [layer0 addSublayer:layer1];


    UIBezierPath * path0 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:10 startAngle:0 endAngle:M_PI*2  clockwise:YES];
    CAShapeLayer * shaperLayer1 = [CAShapeLayer layer];
    shaperLayer1.fillColor = [UIColor blackColor].CGColor;
    shaperLayer1.path = path0.CGPath;
    shaperLayer1.position = CGPointMake(75, 75);
    [layer1 addSublayer:shaperLayer1];

    
    UIBezierPath * path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:10 startAngle:0 endAngle:M_PI*2  clockwise:YES];
    CAShapeLayer * shaperLayer2 = [CAShapeLayer layer];
    shaperLayer2.fillColor = [UIColor blackColor].CGColor;
    shaperLayer2.path = path1.CGPath;
    [layer1 addSublayer:shaperLayer2];
    shaperLayer2.position = CGPointMake(96, 75);
    
    CABasicAnimation * animationScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animationScale.toValue = @(0.5);
    animationScale.fromValue = @(1.0);
    animationScale.repeatCount = HUGE_VAL;
    animationScale.duration = 1.0;
    animationScale.autoreverses = YES;
    
    CABasicAnimation * anmination_x = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    anmination_x.toValue = [NSValue valueWithCGPoint:CGPointMake(30,0)];
    anmination_x.duration = 2.0;
    anmination_x.repeatCount = HUGE_VAL;
    anmination_x.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    
    
    
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = 2;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    replicatorLayer.frame = CGRectMake(0, 0, 150, 150);
    [layer0 addSublayer:replicatorLayer];
    
    [replicatorLayer addSublayer:layer1];
    
    CABasicAnimation * anmination0 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anmination0.toValue = @0;
    anmination0.fromValue = @(M_PI*2);
    anmination0.duration = 1.0;
    anmination0.repeatCount = HUGE_VAL;
    [layer1 addAnimation:anmination0 forKey:@"transform.rotation.z"];
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[animationScale,anmination_x];
    group.duration = 1.0;
    group.repeatCount = HUGE_VAL;
    group.autoreverses = YES;
    [shaperLayer2 addAnimation:group forKey:@"group"];
    
    [shaperLayer1 addAnimation:animationScale forKey:@"transform.scale"];
}


- (void)creatText9{

    CALayer * layer0 = [CALayer layer];
    layer0.frame = CGRectMake(20, 350, 150, 150);
    layer0.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:layer0];

    
    UIBezierPath * path0 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:10 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer * shapeLayer0 = [CAShapeLayer layer];
    shapeLayer0.position = CGPointMake(75, 75);
    shapeLayer0.path = path0.CGPath;
    shapeLayer0.fillColor = [UIColor blackColor].CGColor;
    [layer0 addSublayer:shapeLayer0];
    
    
    UIBezierPath * path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:10 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer * shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.position = CGPointMake(55, 75);
    shapeLayer1.path = path1.CGPath;
    shapeLayer1.fillColor = [UIColor blackColor].CGColor;
    [layer0 addSublayer:shapeLayer1];
    
    
    UIBezierPath * path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:10 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer * shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.position = CGPointMake(95, 75);
    shapeLayer2.path = path2.CGPath;
    shapeLayer2.fillColor = [UIColor blackColor].CGColor;
    [layer0 addSublayer:shapeLayer2];
    
    
   
    self.shaper1 = shapeLayer1;
    self.shaper2 = shapeLayer2;
    self.shaper3 = shapeLayer0;
    
    [self addAnimation:shapeLayer1 and:shapeLayer2 and:shapeLayer0];
    
}


- (void)addAnimation:(CAShapeLayer *)shapeLayer1 and:(CAShapeLayer *)shapeLayer2 and:(CAShapeLayer *)shaperLayer0{

    

    UIBezierPath * ArcPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(75, 75) radius:20 startAngle:0 endAngle:M_PI*2 clockwise:NO];
    
    UIBezierPath * ArcPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(75, 75) radius:20 startAngle:M_PI endAngle:-M_PI clockwise:NO];
    
    CAKeyframeAnimation * keyAnmation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnmation1.path = ArcPath1.CGPath;
    keyAnmation1.duration = 1.2;
    keyAnmation1.repeatCount = 1.0;
    keyAnmation1.calculationMode = kCAAnimationCubic;
    keyAnmation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    keyAnmation1.delegate = self;
    keyAnmation1.fillMode = kCAFillModeForwards;
    keyAnmation1.autoreverses = NO;
    [shapeLayer1 addAnimation:keyAnmation1 forKey:@"position"];
    
    
    CAKeyframeAnimation * keyAnmation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnmation2.path = ArcPath2.CGPath;
    keyAnmation2.duration = 1.2;
    keyAnmation2.repeatCount = 1.0;
    keyAnmation2.calculationMode = kCAAnimationCubic;
    keyAnmation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    keyAnmation2.fillMode = kCAFillModeForwards;
    keyAnmation2.autoreverses = NO;
    [shapeLayer2 addAnimation:keyAnmation2 forKey:@"position"];
}



- (void)creatText10{

    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor greenColor];
    [bt setTitle:@"G" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(bt) forControlEvents:UIControlEventTouchUpInside];
    bt.frame = CGRectMake(150, 64, 50, 30);
    
    [self.view addSubview:bt];
    


}


- (void)bt{
    FViewController * vi = [[FViewController alloc]init];
    
    [self.navigationController pushViewController:vi animated:YES];

}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self buttonAction];
}






- (void)collectionViewCreat{
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-11) collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[collection_Cell class] forCellWithReuseIdentifier:@"oneCell"];
    
    [collectionView registerClass:[collection_TwoCell class] forCellWithReuseIdentifier:@"twoCell"];
    
    self.collectionView = collectionView;
    
    [collectionView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:collectionView];
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellid1 = @"oneCell";
    static NSString * cellid2 = @"twoCell";

    
    if (indexPath.row == 1) {
        collection_Cell * cell1 = (collection_Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellid1 forIndexPath:indexPath];
        
        
        for (UIView * subView in cell1.contentView.subviews) {
            
            [subView removeFromSuperview];
        }
        
        cell1.nameLable.text = [NSString stringWithFormat:@"%ld-->",indexPath.row];
//        cell1.headImageView.image = [UIImage imageNamed:@"00.jpg"];
        cell1.backgroundColor = [UIColor whiteColor];
        return cell1;

        
    }else{
        
        collection_TwoCell * cell2 = (collection_TwoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellid2 forIndexPath:indexPath];

        for (UIView * subView in cell2.contentView.subviews) {
            
            [subView removeFromSuperview];
        }
        
        cell2.nameLable.text = [NSString stringWithFormat:@"%ld++>",indexPath.row];
        cell2.backgroundColor = [UIColor whiteColor];
        return cell2;

    
    }
    
    
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return  CGSizeMake(SCREEN_W, SCREEN_W/4);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{


    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 1;
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 5;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld---%ld",indexPath.section,indexPath.row);


}



- (void)dismiss{

    wkWebViewController * wk = [[wkWebViewController alloc]init];
    
    [self.navigationController pushViewController:wk animated:YES];
}


@end
