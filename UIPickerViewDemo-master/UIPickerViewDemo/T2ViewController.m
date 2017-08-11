//
//  T2ViewController.m
//  UIPickerViewDemo
//
//  Created by 潘振泽 on 16/6/13.
//  Copyright © 2016年 潘振泽. All rights reserved.
//

#import "T2ViewController.h"

@interface T2ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong)NSArray * provinces;//展示省份
@property (nonatomic,strong)NSArray * cities;//展示城市
@property (nonatomic,strong)UILabel * label;

@end

@implementation T2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}
-(void)loadData{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
    self.provinces = [NSArray arrayWithContentsOfFile:path];
    self.cities = [NSArray arrayWithArray:self.provinces[0][@"Cities"]];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectZero];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.label.textColor = [UIColor greenColor];
    self.label.font = [UIFont systemFontOfSize:30];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.label];
    NSArray * labelTop = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pickerView]-30-[_label(50)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pickerView,_label)];
    NSArray * labelH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_label]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_label)];
    [self.view addConstraints:labelTop];
    [self.view addConstraints:labelH];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger rows = 0;
    switch (component) {
        case 0:
            rows = self.provinces.count;
            break;
        case 1:
            rows = self.cities.count;
            break;
        default:
            break;
    }
    return rows;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.provinces[row][@"State"];
            break;
        case 1:
            title = self.cities[row][@"city"];
            break;
        default:
            break;
    }
    return title;
}

//选中时回调的委托方法，在此方法中实现省份和城市间的联动
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0://选中省份表盘时，根据row的值改变城市数组，刷新城市数组
            self.cities = self.provinces[row][@"Cities"];
            [self.pickerView reloadComponent:1];
            break;
        case 1:
            //            NSLog(@"当前选择目的地为：%@%@",self.provinces[[self.pickerView selectedRowInComponent:0]][@"State"],self.cities[[self.pickerView selectedRowInComponent:1]][@"city"]);
            self.label.text = [NSString stringWithFormat:@"%@%@",self.provinces[[self.pickerView selectedRowInComponent:0]][@"State"],self.cities[[self.pickerView selectedRowInComponent:1]][@"city"]];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
