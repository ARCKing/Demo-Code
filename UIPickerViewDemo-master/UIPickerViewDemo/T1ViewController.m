//
//  T1ViewController.m
//  UIPickerViewDemo
//
//  Created by 潘振泽 on 16/6/13.
//  Copyright © 2016年 潘振泽. All rights reserved.
//

#import "T1ViewController.h"

@interface T1ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong)NSArray * datas;//存放数据

@end

@implementation T1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取数据
    [self loadData];
    //指定委托和数据源
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}
#pragma mark 获取数据
-(void)loadData{
    //通过NSBundle获取文件路径
    NSString * path = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
    //通过路径获取文件数据
    self.datas = [NSArray arrayWithContentsOfFile:path];
    
}
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//指定每个表盘有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.datas.count;
}
//指定每行要展示的数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.datas[row];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
