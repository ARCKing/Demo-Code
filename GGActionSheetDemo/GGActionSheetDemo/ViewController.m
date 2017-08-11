//
//  ViewController.m
//  GGActionSheetDemo
//
//  Created by iOSer on 2017/1/10.
//  Copyright © 2017年 gggg. All rights reserved.
//

#import "ViewController.h"
#import "GGActionSheet.h"
@interface ViewController ()<GGActionSheetDelegate>
@property(nonatomic,strong) GGActionSheet *actionSheetImg;
@property(nonatomic,strong) GGActionSheet *actionSheetTitle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
    [btn1 setTitle:@"图片类型" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor blackColor]];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 30)];
    [btn2 setTitle:@"标题类型" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor blackColor]];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
}

-(void)btn1Click{
    [self.actionSheetImg showGGActionSheet];
}


-(void)btn2Click{
    [self.actionSheetTitle showGGActionSheet];
}

#pragma mark - GGActionSheet代理方法
-(void)GGActionSheetClickWithActionSheet:(GGActionSheet *)actionSheet Index:(int)index{
    if (actionSheet == self.actionSheetTitle) {
        
    NSLog(@"--------->点击了第%d个按钮<----------",index);
    }
}
-(GGActionSheet *)actionSheetImg{
    if (!_actionSheetImg) {
        _actionSheetImg = [GGActionSheet ActionSheetWithImageArray:@[@"alipay233",@"wechatpay233"] delegate:self];
        _actionSheetImg.cancelDefaultColor = [UIColor redColor];
    }
    return _actionSheetImg;
}

-(GGActionSheet *)actionSheetTitle{
    if (!_actionSheetTitle) {
        _actionSheetTitle = [GGActionSheet ActionSheetWithTitleArray:@[@"支付宝支付",@"微信支付"] andTitleColorArray:@[[UIColor orangeColor]] delegate:self];
        //取消按钮颜色设置
        _actionSheetTitle.cancelDefaultColor = [UIColor blueColor];
        //如果设置了选项颜色 当颜色数组和标题数组数量对不上时 多余标题使用选项默认颜色
        //如果设置了选项颜色 当颜色数组传空时，所有选项默认使用选项颜色
        //如果没设置选项颜色 数量对不上以及颜色数组为空时都使用默认黑色
        _actionSheetTitle.optionDefaultColor = [UIColor greenColor];
    }
    return _actionSheetTitle;
}

@end
