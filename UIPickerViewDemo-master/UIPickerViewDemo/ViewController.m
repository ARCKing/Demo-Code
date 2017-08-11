//
//  ViewController.m
//  UIPickerViewDemo
//
//  Created by 潘振泽 on 16/6/13.
//  Copyright © 2016年 潘振泽. All rights reserved.
//PickerView是用来展示数据的组件

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIPickerView * pickerView;
@property (nonatomic,strong)NSArray * letter;//保存字母
@property (nonatomic,strong)NSArray * number;//保存数字

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取需要展示的数据
    [self loadData];
    
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 200)];
    //    self.pickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.pickerView];
    
    //指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}
#pragma mark 加载数据
-(void)loadData{
    //需要展示的数据以数组的形式保存
    self.letter = @[@"aaa",@"bbb",@"ccc",@"ddd"];
    self.number = @[@"111",@"222",@"333",@"444"];
}
#pragma mark UIPickerView DataSource Method
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.letter.count;
            break;
        case 1:
            result = self.number.count;
            break;
            
        default:
            break;
    }
    return result;
}
#pragma mark UIPickerView Delegate Method
//指定每行如何展示数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.letter[row];
            break;
        case 1:
            title = self.number[row];
            break;
        default:
            break;
    }
    return title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

