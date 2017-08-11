//
//  CyhSliderVC.m
//  CyhSlider
//
//  Created by Macx on 16/8/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "CyhSliderVC.h"

static CyhSliderVC * cyhslider;
static UINavigationController * mynvc;
@interface CyhSliderVC ()<UIGestureRecognizerDelegate>

@property (nonatomic , strong)UIBarButtonItem * leftItem;
@property (nonatomic , strong)UIButton * pushBtn;

@end

@implementation CyhSliderVC
{
    UIView * mainview;
    UIView * leftview;
    UIView * rightview;
    CGPoint mainPoint;
    CGRect moveframe;
    UIScreenEdgePanGestureRecognizer * _sPanGR;
    UIPanGestureRecognizer * rightpanGR;
    UITapGestureRecognizer * _TapGR;
}


+(CyhSliderVC *)initCyhslider
{
    static dispatch_once_t Token;
    dispatch_once(&Token, ^{
    if(!cyhslider){

        cyhslider = [CyhSliderVC new];

       }
    });

    return cyhslider;
    
}

- (void)AddSliderLeftItem:(NSString *)Itemtitle Itemtitlecolor:(UIColor *)Itemcolor UImage:(UIImage *)image Trag:(UIViewController *)trag
{
    self.pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _pushBtn.selected = YES;
    if (image&&Itemtitle == nil) {
       
        [_pushBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    else if (image== nil && Itemtitle)
    {
        [_pushBtn setTitle:Itemtitle forState:UIControlStateNormal];
        if (Itemcolor) {
            [_pushBtn setTitleColor:Itemcolor forState:
             UIControlStateNormal];
        }else
        {
        [_pushBtn setTitleColor:[UIColor blackColor] forState:
         UIControlStateNormal];
        }
    }
    
    [_pushBtn addTarget:self action:@selector(sliderBlicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * Bitem = [[UIBarButtonItem alloc] initWithCustomView:_pushBtn];
    trag.navigationItem.leftBarButtonItem = Bitem;
    
}

- (void)sliderBlicked:(UIButton *)btn
{
    self.pushBtn.selected = !_pushBtn.selected;
    if (btn.selected == NO) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            mainview.frame = CGRectMake(self.view.frame.size.width * 2/3, 0, self.view.frame.size.width, self.view.frame.size.height);
            _sPanGR.enabled = NO;
            rightpanGR.enabled = YES;
            _TapGR.enabled = YES;
        }];
    }
   else
   {
       [UIView animateWithDuration:0.3 animations:^{
           
           mainview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
           _sPanGR.enabled = YES;
           rightpanGR.enabled = NO;
           _TapGR.enabled = NO;
       }];
   
   }
    
}

- (void)addMainVC:(UIViewController *)Mainvc addLeftVC:(UIViewController *)LeftVC
{
    [CyhSliderVC initCyhslider].Mainvc = Mainvc;
    [CyhSliderVC initCyhslider].Leftvc = LeftVC;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.Leftvc];
    [self addChildViewController:self.Mainvc];
    
    mainview = [[UIView alloc] initWithFrame:self.view.bounds];
    leftview = [[UIView alloc] initWithFrame:self.view.bounds];
//    rightview = [[UIView alloc] initWithFrame:self.view.bounds];
    mainview.backgroundColor = [UIColor whiteColor];
    leftview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:leftview];
    [self.view addSubview:mainview];
    [mainview addSubview:self.Mainvc.view];
    [leftview addSubview:self.Leftvc.view];

    
    [_Mainvc didMoveToParentViewController:self];
    [_Leftvc didMoveToParentViewController:self];
 
    [self creatScreenPangGesture];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];


}


- (void)creatScreenPangGesture
{
    _sPanGR = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(sPanGRBlicked:)];
    _sPanGR.delegate = self;
    _sPanGR.maximumNumberOfTouches = 1;
    _sPanGR.minimumNumberOfTouches = 1;
    _sPanGR.edges = UIRectEdgeLeft;
    _sPanGR.enabled = YES;
    
    _TapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGRBlicked:)];
    _TapGR.delegate = self;
    _TapGR.enabled = NO;
    
   rightpanGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightpanGRBlicked:)];
    rightpanGR.maximumNumberOfTouches = 1;
    rightpanGR.minimumNumberOfTouches = 1;
    rightpanGR.enabled = NO;
    
    mainview.userInteractionEnabled = YES;
    mainview.multipleTouchEnabled = YES;
    [mainview addGestureRecognizer:_sPanGR];
    [mainview addGestureRecognizer:rightpanGR];
    [mainview addGestureRecognizer:_TapGR];
}

- (void)TapGRBlicked:(UITapGestureRecognizer *)TapGR
{
    [UIView animateWithDuration:0.3 animations:^{
        
        mainview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _sPanGR.enabled = YES;
        rightpanGR.enabled = NO;
        _TapGR.enabled = NO;
        self.pushBtn.selected = YES;
    }];

}

- (void)rightpanGRBlicked:(UIPanGestureRecognizer *)panGR
{
    CGPoint point = [panGR translationInView:self.view];
   
    if (panGR.state == UIGestureRecognizerStateBegan) {

        mainPoint = point;
        
    }
    if (panGR.state == UIGestureRecognizerStateChanged) {

        moveframe = mainview.frame;
        moveframe.origin.x = self.view.frame.size.width * 2/3 + (point.x - mainPoint.x);
        mainview.frame = CGRectMake(moveframe.origin.x, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        if (mainview.frame.origin.x <= 0) {
            mainview.frame = CGRectMake(0, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        }
        
    }
    if (panGR.state == UIGestureRecognizerStateEnded) {

        if (mainview.frame.origin.x >= self.view.frame.size.width * 1/2){
            
            
            [UIView animateWithDuration:0.2 animations:^{
                mainview.frame = CGRectMake(self.view.frame.size.width * 2/3, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                self.pushBtn.selected = NO;
                _TapGR.enabled = YES;
            }];
            
        }
        else
        {
            [UIView animateWithDuration:0.2 animations:^{
                mainview.frame = CGRectMake(0, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                
            } completion:^(BOOL finished) {
                self.pushBtn.selected = YES;
                rightpanGR.enabled = NO;
                _sPanGR.enabled = YES;
                _TapGR.enabled = NO;
            }];
            
            
        }
 }

}
- (void)sPanGRBlicked:(UIScreenEdgePanGestureRecognizer *)sPanGR
{
    
    CGPoint point = [sPanGR translationInView:self.view];
    
    if (sPanGR.state == UIGestureRecognizerStateBegan) {

       mainPoint = [sPanGR translationInView:self.view];
        
    }
    if (sPanGR.state == UIGestureRecognizerStateChanged) {
        
        moveframe = mainview.frame;
        moveframe.origin.x = point.x - mainPoint.x;
        mainview.frame = CGRectMake(moveframe.origin.x, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        if (mainview.frame.origin.x > self.view.frame.size.width * 2/3)
        {
            mainview.frame = CGRectMake(self.view.frame.size.width * 2/3, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        }
    }
    if (sPanGR.state == UIGestureRecognizerStateEnded) {

        if (mainview.frame.origin.x >= self.view.frame.size.width * 1/2)
        {
            [UIView animateWithDuration:0.2 animations:^{
                mainview.frame = CGRectMake(self.view.frame.size.width * 2/3, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                
                 self.pushBtn.selected = NO;
                rightpanGR.enabled = YES;
                _sPanGR.enabled = NO;
                _TapGR.enabled = YES;
            }];
            
        }
        else
        {
            [UIView animateWithDuration:0.2 animations:^{
                mainview.frame = CGRectMake(0, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                
            } completion:^(BOOL finished) {
                
                self.pushBtn.selected = YES;
                _TapGR.enabled = NO;
                
                
            }];
          
            
        }
    }
    

}

- (void)pushSubvc:(id)trag
{
    [UIView animateWithDuration:0.3 animations:^{
        
        mainview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _sPanGR.enabled = YES;
        rightpanGR.enabled = NO;
        _TapGR.enabled = NO;
        self.pushBtn.selected = YES;
    }];
    [self.pudelegate pushsubVC:trag];
    
}

@end
