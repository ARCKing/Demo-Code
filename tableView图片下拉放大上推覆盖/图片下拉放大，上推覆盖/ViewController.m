//
//  ViewController.m
//  图片下拉放大，上推覆盖
//
//  Created by wuzz on 2016/12/28.
//  Copyright © 2016年 wuzz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor  = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height ) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - 200, self.view.frame.size.width, 200)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = [UIImage imageNamed:@"background_image.jpg"];
    
    [self.tableView addSubview:self.imageView];
    
    //sendSubviewToBack  将 image 放在 tableview 的最后面
    [self.tableView sendSubviewToBack:self.imageView];
}


// 利用scrollView的代理滚动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect targetFrame = self.imageView.frame;
    
    CGFloat y = scrollView.contentOffset.y;
    
    CGFloat offset =  - scrollView.contentOffset.y - scrollView.contentInset.top;
    
    if (offset < 0) {  // 说明image正在被遮盖
        //上推中....
        offset *= -3.0f;
        targetFrame.origin.y = - scrollView.contentInset.top + offset/4;
        self.imageView.frame = targetFrame;
        
    }else{
        //下拉中....
        if (y + scrollView.contentInset.top <= 0) { // 说明image完全显示
            self.imageView.frame = CGRectMake(y + 200, y , self.view.frame.size.width - (y + 200) * 2, -y);
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"下拉，上推----%ld",indexPath.row];
    
    return cell;
}


@end
