//
//  FViewController.m
//  弹框
//
//  Created by gxtc on 17/1/11.
//  Copyright © 2017年 root. All rights reserved.
//

#import "FViewController.h"

@interface FViewController ()
@property (nonatomic,strong)UIView * redView;
@property (nonatomic,strong)UIView * greView;
@property (nonatomic,strong)UIView * orgView;
@property (nonatomic,strong)UIView * sView;

@property (nonatomic,strong)UIDynamicAnimator * anmicanimator;
@property (nonatomic,strong)UIGravityBehavior * gravityBehavior;

@end

@implementation FViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.redView =[[ UIView alloc]initWithFrame:CGRectMake(100, 64, 30, 30)];
    [self.view addSubview:self.redView];
    self.redView.backgroundColor = [UIColor redColor];
    
    self.orgView =[[ UIView alloc]initWithFrame:CGRectMake(90, 250, 150, 30)];
    [self.view addSubview:self.orgView];
    self.orgView.backgroundColor = [UIColor orangeColor];
    
    self.greView =[[ UIView alloc]initWithFrame:CGRectMake(150, 300, 30, 30)];
    [self.view addSubview:self.greView];
    self.greView.backgroundColor = [UIColor greenColor];
    
    
    self.redView.layer.cornerRadius = 15;
    self.redView.clipsToBounds = YES;
    
//    self.greView.layer.cornerRadius = 15;
//    self.greView.clipsToBounds = YES;
//
    self.orgView.layer.cornerRadius = 15;
    self.orgView.clipsToBounds = YES;
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 350, 200, 30)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    self.sView = view;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self gravityBehaviorAction];
    
    [self pushBehaviorAction];

    [self AttachmentBehaviorAction];
}


#pragma mark- 自由落体+碰撞
//自由落体 + 碰撞
- (void)gravityBehaviorAction{
                                                                        //参考视图
    UIDynamicAnimator * anmicanimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    self.anmicanimator = anmicanimator;//强引用anmicanimator，否则代码块执行完成后，将被释放，动画无法完成
    
    //自由落体
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[self.redView,self.orgView,self.greView]];
    
    gravityBehavior.gravityDirection = CGVectorMake(0,1);//重力矢量方向
    
//    gravityBehavior.angle = M_PI/2;//方向
    
    gravityBehavior.magnitude = 1.0;//加速度
    
    [anmicanimator addBehavior:gravityBehavior];

    //碰撞
    UICollisionBehavior * collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.redView,self.orgView,self.greView]];
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;

    [collisionBehavior addBoundaryWithIdentifier:@"liness" fromPoint:CGPointMake(0, 350) toPoint:CGPointMake(200, 350)];
    
    [anmicanimator addBehavior:collisionBehavior];
    
}


#pragma mark- 吸附行为
- (void)SnapBehaviorAction:(NSSet *)touches{

    UIDynamicAnimator * anmicanimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    self.anmicanimator = anmicanimator;//强引用anmicanimator，否则代码块执行完成后，将被释放，动画无法完成

    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    UISnapBehavior * snapBehavior = [[UISnapBehavior alloc]initWithItem:self.redView snapToPoint:point];
    
    snapBehavior.damping = 0.6;//阻尼系数
    
    [anmicanimator addBehavior:snapBehavior];
    
}


#pragma mark- 推动行为
- (void)pushBehaviorAction{

//    UIDynamicAnimator * anmicanimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
//    
//    self.anmicanimator = anmicanimator;//强引用anmicanimator，否则代码块执行完成后，将被释放，动画无法完成

    UIPushBehavior * pushBehavior = [[UIPushBehavior alloc]initWithItems:@[self.greView,self.redView,self.greView] mode:UIPushBehaviorModeContinuous];
    pushBehavior.pushDirection = CGVectorMake(0,1);
    pushBehavior.magnitude = 1.0;
    [pushBehavior setTargetOffsetFromCenter:UIOffsetMake(200, 300) forItem:self.greView];//推力作用点的偏移量，默认是center。
    


    [self.anmicanimator addBehavior:pushBehavior];
    
}


#pragma mark-附着行为
- (void)AttachmentBehaviorAction{

    
    
//    分为刚性附着和弹性附着
//    1、刚性附着，固定了length就是刚性附着，红、蓝两点距离固定
//    attachment.length = 100;
//    2、弹性附着（设置了频率和振幅），红、蓝两色像皮筋一样距离不固定
//    attachment.damping = 0;
//    attachment.frequency = 0.5;
    
    
    
    UIAttachmentBehavior * attachmenBehavior = [[UIAttachmentBehavior alloc]initWithItem:self.redView attachedToItem:self.greView];
    
    attachmenBehavior.damping = 0.1;
    attachmenBehavior.frequency = 1.0;
    
    [self.anmicanimator addBehavior:attachmenBehavior];
    
    
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGest:)];
    
    [self.sView addGestureRecognizer:pan];
    
}


- (void)panGest:(UIPanGestureRecognizer *)pan{

    
    
    
}

@end
