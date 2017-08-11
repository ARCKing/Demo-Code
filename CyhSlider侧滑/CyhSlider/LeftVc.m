//
//  LeftVc.m
//  CyhSlider
//
//  Created by Macx on 16/8/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LeftVc.h"
#import "subVC.h"
#import "MainVC.h"
#import "CyhSliderVC.h"

@interface LeftVc ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic ,strong)UITableView * tableview;

@end

@implementation LeftVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgimageview.image = [UIImage imageNamed:@"BG.jpg"];
    [self.view addSubview:bgimageview];
    
    [self createTableview];
    
}


- (void)createTableview
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,100, self.view.frame.size.width *2/3 - 10, self.view.frame.size.height - 200) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = @"设定。。。";
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    subVC * svc = [[subVC alloc] init];
    svc.showtext = @[@"跳转到下一页了"];
//这里跳转需要调用方法跳转，不能直接跳转，否者。。。，想知道试一下你就知道了
    [[CyhSliderVC initCyhslider] pushSubvc:svc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
