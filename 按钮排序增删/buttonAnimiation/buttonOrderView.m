//
//  buttonOrderView.m
//  buttonAnimiation
//
//  Created by gxtc on 16/9/21.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "buttonOrderView.h"

#define Screen_W [UIScreen mainScreen].bounds.size.width
#define Screen_H [UIScreen mainScreen].bounds.size.height

#define button_w Screen_W / 9
#define button_h Screen_W / 15

@interface buttonOrderView ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)NSMutableArray * selectArray;
@property (nonatomic,strong)NSMutableArray * unSelectArray;
@property (nonatomic,strong)UIView * lineView;

@property (nonatomic,strong)UIButton * upLastBt;
@property (nonatomic,strong)UIButton * downLastBt;


@property (nonatomic,strong)NSMutableArray * PointNewArray;

@property (nonatomic,strong)UIButton * lineButton;


@property (nonatomic,strong)UIPanGestureRecognizer * panGesture;

@property (nonatomic,strong)UIButton * addPanButton;

@property (nonatomic,assign)CGPoint oldCenter;

@property (nonatomic,assign)NSInteger a;
@property (nonatomic,assign)NSInteger b;
@property (nonatomic,assign)NSInteger c;
@property (nonatomic,assign)int temp_i;


@property (nonatomic,strong)NSMutableArray * centArray;

@end


@implementation buttonOrderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self.backgroundColor = [UIColor redColor];
    
    NSArray * array1 = @[@"热门",@"科技",@"段子",@"美文",@"两性",@"教育",@"情感",@"家具",@"健康",@"旅游",@"励志",@"宠物",@"历史",@"美食",@"财经",@"房产",@"星座",@"推荐"];
    
    NSArray * array2 = @[@"社会",@"创业",@"汽车",@"美女",@"育儿",@"搞笑",@"时尚",@"军事",@"视频",@"娱乐",@"游戏",@"数码",@"体育"];
    
    _PointNewArray = [NSMutableArray new];
    
    _selectArray = [NSMutableArray new];
    
    _unSelectArray = [NSMutableArray new];
    
    _centArray = [NSMutableArray new];
    
    
    if (self = [super initWithFrame:frame]) {
        
        for (int i = 0; i < array1.count ; i++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:array1[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.layer.borderColor = [UIColor blackColor].CGColor;
            button.layer.borderWidth = 0.5;
            button.layer.cornerRadius = 5;
            button.tag = 1;
            button.frame = CGRectMake(0, 0, button_w,button_h);
            CGPoint btcenter = CGPointMake( (Screen_W - button_w * 4)/5 + button_w/2  + ( button_w + (Screen_W - button_w * 4)/5)* (i % 4), 44 + ( button_h * 2) * (i /4));
            
            button.center = btcenter;
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [_selectArray addObject:button];
            
            
            //NSValue <- CGPoint
            NSValue * centValue =  [NSValue valueWithCGPoint:btcenter];
            
            [_centArray addObject:centValue];
            
            
            //NSValue -> CGPoint
//            NSValue * val = _centArray[0];
//            CGPoint poi = [val CGPointValue];
            
            
        }
        
        UIButton * lastBt = [_selectArray lastObject];
        
        NSLog(@"%@",lastBt.titleLabel.text);
        
        self.lineView = [[UIView alloc]init];
        self.lineView.frame = CGRectMake( 0,0,Screen_W, Screen_W/14);
        self.lineView.center = CGPointMake(Screen_W/2, CGRectGetMaxY(lastBt.frame) + Screen_W/14);
        
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineView];
        
        
        self.lineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.lineButton.backgroundColor = [UIColor lightGrayColor];
        [self.lineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.lineButton setTitle:@"完成" forState:UIControlStateNormal];
        self.lineButton.frame = CGRectMake(0, 0, button_w - 5, button_h - 5);
        self.lineButton.center = CGPointMake(_lineView.frame.size.width - button_w - 20, _lineView.frame.size.height/2);
        self.lineButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.lineButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.lineButton.layer.borderWidth = 1;
        self.lineButton.layer.cornerRadius = 10;
        [self.lineView addSubview:_lineButton];
        [self.lineButton addTarget:self action:@selector(lineButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_W/3, Screen_W/14)];
        lineLabel.center = CGPointMake(Screen_W/6 , Screen_W/28);
        lineLabel.text = @"点击添加频道";
        lineLabel.textColor =[ UIColor whiteColor];
        lineLabel.font = [UIFont systemFontOfSize:14];
        lineLabel.textAlignment = NSTextAlignmentCenter;
        [self.lineView addSubview:lineLabel];
        
        
        for (int i = 0; i < array2.count ; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:array2[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.layer.borderColor = [UIColor blackColor].CGColor;
            button.layer.borderWidth = 0.5;
            button.layer.cornerRadius = 5;

            button.frame = CGRectMake(0, 0, button_w,button_h);
            
            button.center = CGPointMake( (Screen_W - button_w * 4)/5 + button_w/2  + ( button_w + (Screen_W - button_w * 4)/5)* (i % 4), CGRectGetMaxY(_lineView.frame)  + button_h + ( button_h * 2) * (i /4));
            
            [self addSubview:button];
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag = 0;
            [_unSelectArray addObject:button];
        }

        
    }
    
    
    _addPanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addPanButton.frame = CGRectMake(0, 0, Screen_W, 30);
    _addPanButton.center = CGPointMake(Screen_W /2,Screen_H - 30);
    _addPanButton.backgroundColor = [UIColor redColor];
    [_addPanButton setTitle:@"添加手势" forState:UIControlStateNormal];
    [_addPanButton addTarget:self action:@selector(addGest) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addPanButton];
    
    
    return self;
}

#pragma mark- 添加拖拽手势
- (void)addGest{
    NSLog(@"添加手势!");
    
//    _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMove:)];
//    
//    [_panGesture addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
//
    for (UIButton * bt in _selectArray) {
        
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMove:)];
        panGesture.delegate = self;
        [panGesture addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];

        [bt addGestureRecognizer:panGesture];

    }
}



#pragma mark- 单独给一个按钮添加拖拽手势
- (void)singleButtonPanAdd:(UIButton *)bt{

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMove:)];
    panGesture.delegate = self;
    [panGesture addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    
    [bt addGestureRecognizer:panGesture];

}





- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    UIButton * bt = (UIButton *)_panGesture.view;
    
    if (_panGesture.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"拖动结束!");
        

        NSLog(@"%@",bt.titleLabel.text);
        
        [bt removeGestureRecognizer:_panGesture];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            bt.center = _oldCenter;
        }];
        
        [self performSelector:@selector(addPanAgain:) withObject:bt afterDelay:0.2];
    }
    
}

//重新添加手势
- (void)addPanAgain:(UIButton *)bt{
    
    [bt addGestureRecognizer:_panGesture];
    
}


- (void)dealloc{
    
    [self.panGesture removeObserver:self forKeyPath:@"state"];
}

#pragma mark- 手势拖动事件
- (void)panMove:(UIPanGestureRecognizer *)pan{

    UIButton * bt = (UIButton *)pan.view;
    
    
    [self selectButtonRank:bt];
    
    _panGesture = pan;
    // 获取相对于self.view的坐标位置
    CGPoint point = [pan locationInView:self];
    
    // 改变视图具体的位置
    pan.view.center = point;
}


#pragma mark-手势将要移动
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    NSLog(@"动了");
    _oldCenter = gestureRecognizer.view.center;
    
    return YES;

}


- (void)lineButtonAction{

    NSLog(@"完成!");

}

#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)bt{
    
    NSLog(@"[[%@]]",bt.titleLabel.text);
    
    //取消频道
    if (bt.tag == 1) {
       
        
        //如果是排序状态
        if (bt.gestureRecognizers) {

        }
        
        [_selectArray removeObject:bt];
        
        bt.tag = 0;
        [_unSelectArray addObject:bt];
        
        
                NSInteger i = (NSInteger)_selectArray.count - 1;
            
                CGPoint newPoint = CGPointMake( (Screen_W - button_w * 4)/5 + button_w/2  + ( button_w + (Screen_W - button_w * 4)/5)* (i % 4), 44 + ( button_h * 2) * (i /4));
                
                UIButton * lastBt = [UIButton buttonWithType:UIButtonTypeCustom];
                lastBt.frame = CGRectMake(0, 0, button_w,button_h );
                lastBt.center = newPoint;
        
                [UIView animateWithDuration:0.25 animations:^{
                    
                    self.lineView.center = CGPointMake(Screen_W/2, CGRectGetMaxY(lastBt.frame) + Screen_W/14);
                    
                }];
        
        
        for (int i = 0; i < _unSelectArray.count; i ++) {
            
            CGPoint newPoint = CGPointMake( (Screen_W - button_w * 4)/5 + button_w/2  + ( button_w + (Screen_W - button_w * 4)/5)* (i % 4), CGRectGetMaxY(_lineView.frame)  + button_h + ( button_h * 2) * (i /4));
            
            
            UIButton * bt = _unSelectArray[i];
            
            
            [self moveAnimation:bt.center andNewPoint:newPoint withButton:bt];
        
        }
     
        [_centArray removeAllObjects];
        
        for (int i = 0 ; i<_selectArray.count;i++) {
            
        CGPoint newPoint = CGPointMake( (Screen_W - button_w * 4)/5 + button_w/2  + ( button_w + (Screen_W - button_w * 4)/5)* (i % 4), 44 + ( button_h * 2) * (i /4));
            
            
            UIButton * bt = _selectArray[i];
            
            
            [self moveAnimation:bt.center andNewPoint:newPoint withButton:bt];
            
            
            NSValue * value = [NSValue valueWithCGPoint:newPoint];
            [_centArray addObject:value];
            

        }
        
       
    //添加频道
    }else if (bt.tag == 0) {
        
        
        //如果是排序状态
        if (_addPanButton) {
           [self singleButtonPanAdd:bt];
        }
        
        
        [_unSelectArray removeObject:bt];
        
        bt.tag = 1;
        [_selectArray addObject:bt];
        
        [_centArray removeAllObjects];
        
        for (int i = 0 ; i<_selectArray.count;i++) {
            
            CGPoint newPoint = CGPointMake( (Screen_W - button_w * 4)/5 + button_w/2  + ( button_w + (Screen_W - button_w * 4)/5)* (i % 4), 44 + ( button_h * 2) * (i /4));
            
            UIButton * bt = _selectArray[i];
            
            [self moveAnimation:bt.center andNewPoint:newPoint withButton:bt];
            
            NSValue * value = [NSValue valueWithCGPoint:newPoint];
            [_centArray addObject:value];
        }

        
        [UIView animateWithDuration:0.25 animations:^{
            UIButton * btLast = [_selectArray lastObject];
            
            self.lineView.center = CGPointMake(Screen_W/2, CGRectGetMaxY(btLast.frame) + Screen_W/14);
            
        }];
        
        
        for (int i = 0; i < _unSelectArray.count; i ++) {
            
            CGPoint newPoint = CGPointMake( (Screen_W - button_w * 4)/5 + button_w/2  + ( button_w + (Screen_W - button_w * 4)/5)* (i % 4), CGRectGetMaxY(_lineView.frame)  + button_h + ( button_h * 2) * (i /4));
            
            
            UIButton * bt = _unSelectArray[i];
            
            
            [self moveAnimation:bt.center andNewPoint:newPoint withButton:bt];
            
        }
            }
}

#pragma mark- 计算要交换的坐标
//计算要交换的坐标
- (void)selectButtonRank:(UIButton *)bt{
    
    NSInteger bt_X = bt.center.x;
    NSInteger bt_Y = bt.center.y;

    NSInteger temp = 10000;
    
    
    for (int i = 0; i  < _centArray.count ; i++) {
        
        if (bt == _selectArray[i]) {
            continue;
        }
        
        NSValue * value = _centArray[i];
        
        CGPoint vaPt = [value CGPointValue];
        
        NSInteger vaPt_X = vaPt.x;
        NSInteger vaPt_Y = vaPt.y;
        //勾股定理
        _a = labs(bt_X - vaPt_X);
        _b = labs(bt_Y - vaPt_Y);
        //开平方计算最小的距离
        _c = sqrtl(_a * _a + _b * _b);
        
        if (temp > _c) {
            temp = _c;
            //交换位置的数组下标
            _temp_i = i;

        }
        
    }
    
    if (temp < button_h + button_h/3) {
        
    CGPoint newPoint = CGPointMake( (Screen_W - button_w * 4)/5 + button_w/2  + ( button_w + (Screen_W - button_w * 4)/5)* (_temp_i % 4), 44 + ( button_h * 2) * (_temp_i /4));
        
       _oldCenter = newPoint;
        
        NSLog(@"-=-=-=-=-=");
        
        [_selectArray removeObject:bt];
        [_selectArray insertObject:bt atIndex:_temp_i];
        
        
//       ============================
        
        //重新计算按钮坐标
        for (int i = 0 ; i<_selectArray.count;i++) {
            
            CGPoint newPoint = CGPointMake( (Screen_W - button_w * 4)/5 + button_w/2  + ( button_w + (Screen_W - button_w * 4)/5)* (i % 4), 44 + ( button_h * 2) * (i /4));
            
            
            UIButton * bt = _selectArray[i];
            
            if (_temp_i != i) {
//      //改变按钮位置
            [self moveAnimation:bt.center andNewPoint:newPoint withButton:bt];
            }
        }
//        ============================
        
    }
    

}


#pragma mark- 坐标移动动画
- (void)moveAnimation:(CGPoint)oldPoint andNewPoint:(CGPoint)newPoint withButton:(UIButton *)bt{

    [UIView animateWithDuration:0.25 animations:^{
        bt.center = newPoint;
    }];

}



@end











