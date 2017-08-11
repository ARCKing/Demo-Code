//
//  ViewController.m
//  NoDataTableview
//
//  Created by gxtc on 2017/6/10.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ViewController.h"
#import "CYLTableViewPlaceHolder.h"
#import "MJRefresh.h"
#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<CYLTableViewPlaceHolderDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)UITableView * tableView2;

@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,assign)NSInteger num;

@property(nonatomic,strong)UIView * buttonView;

@property(nonatomic,strong)UIImageView * imageHeadView;

@property(nonatomic,strong)UIActivityIndicatorView  * indicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.num = 2;
    
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.imageHeadView];
    [self.view addSubview:self.buttonView];
    
    
}



- (UIActivityIndicatorView *)indicatorView{

    
    if (!_indicatorView) {
        
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.backgroundColor = [UIColor clearColor];
        _indicatorView.center = CGPointMake(ScreenWith/2, 44);
        _indicatorView.color = [UIColor blackColor];
    }

    [_indicatorView startAnimating];
    
    return _indicatorView;
}



- (UIView *)buttonView{

    if (!_buttonView) {
        
        _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/3 - ScreenWith/8, ScreenWith, ScreenWith/8)];
        _buttonView.backgroundColor = [UIColor purpleColor];
        
        NSArray * btName = @[@"点1",@"点2"];
        
        for (int i = 0; i < 2; i++) {
            
            UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.backgroundColor = [UIColor redColor];
            [bt setTitle:btName[i] forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            bt.frame = CGRectMake(ScreenWith/6 + ScreenWith/3 * i, 0, ScreenWith/3, ScreenWith/8);
            [bt addTarget:self action:@selector(buttonChannelAction:) forControlEvents:UIControlEventTouchUpInside];

            bt.tag = i + 110;
            [_buttonView addSubview:bt];
        }
        
    }
    
    return _buttonView;
}


- (void)buttonChannelAction:(UIButton *)bt{

    NSLog(@"频道");
    if (bt.tag == 110) {
    
//        self.scrollView.contentOffset = CGPointMake(0, 0);
        
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }else{
    
        [self.scrollView setContentOffset:CGPointMake(ScreenWith, 0) animated:YES];

    }
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSLog(@"111111");

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.tag == 334455) {
        
        return;
    }
    
    
    if (scrollView.tag == 112233) {
    
        self.tableView2.contentOffset = scrollView.contentOffset;
        
    }else if (scrollView.tag == 223344){
    
        self.tableView.contentOffset = scrollView.contentOffset;

    
    }
    
    
    
    //下拉为负-，上推为正+
    
    NSLog(@"222222");
    
    NSLog(@"%f",scrollView.contentOffset.y);
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGRect titleFrame = self.buttonView.frame;
    
    
    NSLog(@"===>>>>>>>%f",offsetY);
    
    titleFrame.origin.y = ScreenHeight/3 - ScreenWith/8 - offsetY;
    
    if (titleFrame.origin.y <= 0) {
        titleFrame.origin.y = 0;
    }
    
    
    self.buttonView.frame = titleFrame;
    
    CGRect imageViewFrame = self.imageHeadView.frame;
    
    if (offsetY < 0) {
        
        imageViewFrame.origin.y = - offsetY;
        imageViewFrame.size.height = ScreenHeight/3;
    }else{
    
        imageViewFrame.size.height = titleFrame.origin.y;
    
    }
    
    
    if (scrollView.contentOffset.y==0) {
        
        imageViewFrame.origin.y = 0;
    }
    
    self.imageHeadView.frame = imageViewFrame;
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenHeight) style:UITableViewStylePlain];
        
       UIView * vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenHeight/3)];
        vv.backgroundColor = [UIColor orangeColor];
        _tableView.tableHeaderView =vv;
        
        
        
        _tableView.rowHeight = ScreenWith/8;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJ_R1)];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.tag = 112233;
        [_tableView.mj_header beginRefreshing];

    }

    return _tableView;
}


- (UITableView *)tableView2{
    if (!_tableView2) {
        
        _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWith, 0, ScreenWith, ScreenHeight) style:UITableViewStylePlain];
       
    
        UIView * vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenHeight/3)];
        vv.backgroundColor = [UIColor orangeColor];
        _tableView2.tableHeaderView =vv;
        

        
        _tableView2.rowHeight = ScreenWith/8;
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJ_R2)];
        _tableView2.tableFooterView = [[UIView alloc]init];
        _tableView2.tag = 223344;
        [_tableView2.mj_header beginRefreshing];
    }
    
    return _tableView2;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenHeight)];
        _scrollView.contentSize = CGSizeMake(ScreenWith *2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        [_scrollView addSubview:self.tableView];
        [_scrollView addSubview:self.tableView2];
        _scrollView.tag = 334455;
    }
    return _scrollView;
}


- (UIImageView *)imageHeadView{

    if (!_imageHeadView) {
        _imageHeadView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenHeight/3)];
        _imageHeadView.image = [UIImage imageNamed:@"00.jpg"];
        
        _imageHeadView.contentMode = UIViewContentModeScaleAspectFill;
        
        //剪裁超出边框的图片
        _imageHeadView.clipsToBounds = YES;
        
    }

    return _imageHeadView;
}


- (void)MJ_R1{
    NSLog(@"刷新");
    
    self.num -= 1;
    
    if (self.num < 0) {
        
        self.num += 2;
    }
    
    
    [self.view addSubview:self.indicatorView];
    
    [self.tableView.mj_header endRefreshing];
    
    [self.tableView cyl_reloadData];
    
//    [self.indicatorView stopAnimating];

}


- (void)MJ_R2{
    NSLog(@"刷新");
    
    self.num -= 1;
    
    if (self.num < 0) {
        
        self.num += 2;
    }
    
    
    [self.tableView2.mj_header endRefreshing];
    
    [self.tableView2 cyl_reloadData];
    
}



- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{

    
    if (tableView.tag == 223344) {
        
        return 5;
    
    }else{
    
        NSInteger numb = 20;
    
        return numb;
    }
}



- (void)btAction{
    
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView2.mj_header beginRefreshing];

}



//仅需使用  cyl_reloadData 代替  reloadData 即可。
//[self.tableView cyl_reloadData];

//仅一个必须实现的协议方法：创建一个自定义的占位视图并返回

//有数据->没数据 会调用一次
- (UIView *)makePlaceHolderView{

    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/3, ScreenWith,ScreenWith)];
    
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith/4, ScreenWith/4)];
    
    
    NSArray * arr = @[@"noNet",@"icon_noD"];
    
    NSInteger  index = arc4random()%2;
    
    image.image =[ UIImage imageNamed:arr[index]];
    
    image.center = v.center;
    
    [v addSubview:image];
    
    
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor redColor];
    [bt setTitle:@"上我" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.frame = CGRectMake(0, 0, ScreenWith/3, ScreenWith/15);
    bt.center = CGPointMake(image.center.x, image.center.y + ScreenWith/5);
    [bt addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:bt];
    
    
    return v;
}

//另外，占位视图默认的设置是不能滚动的，也就不能下拉刷新了，但是如果想让占位视图可以滚动，则需要实现下面的可选代理方法。
- (BOOL)enableScrollWhenPlaceHolderViewShowing{

    return YES;
}
@end
