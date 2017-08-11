//
//  ViewController.m
//  buttonAnimiation
//
//  Created by gxtc on 16/9/21.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "ViewController.h"
#import "buttonOrderView.h"
@interface ViewController ()

@property (nonatomic,strong)NSMutableArray * buttonArray;
@property (nonatomic,strong)buttonOrderView * btView;
@property (nonatomic,strong)CALayer * btttt;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.btView = [[buttonOrderView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_btView];
    
    
    
    CALayer * button = [CALayer layer];
    button.frame = CGRectMake(0, 0, 50, 30);
    button.position = CGPointMake(250, 300);
//    [self.view.layer addSublayer:button];
    button.backgroundColor = [UIColor blackColor].CGColor;
    _btttt = button;
    
    
    
}

- (void)move{

    NSLog(@"dong");
    
    [self moveAnimation:_btttt.position andNewPoint:CGPointMake(150, 300) withButton:_btttt];


}

- (void)moveAnimation:(CGPoint)oldPoint andNewPoint:(CGPoint)newPoint withButton:(CALayer *)bt{
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:oldPoint];
    animation.toValue = [NSValue valueWithCGPoint:newPoint];
    
    animation.duration = 1;
    
    //  移动后位置不变
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [bt addAnimation:animation forKey:@"translate"];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
