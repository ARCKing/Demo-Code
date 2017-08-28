///Users/liyuli/Desktop/CanPlay/CanPlay/ViewController.m
//  ViewController.m
//  CanPlay
//
//  Created by liyuli on 16/11/2.
//  Copyright © 2016年 6mai. All rights reserved.
//

#import "ViewController.h"
#import "TableCell.h"
#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UIButton *BayBtn;

@property (weak, nonatomic) IBOutlet UIView *bayViiew;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic)UICollectionView *collectionDay;

@property(nonatomic,strong)NSArray *arr;

@property(nonatomic,strong)NSArray *headArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionViewDay];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"GoBay";
    
      [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TableCell"];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.collectionDay.hidden=YES;
    
    self.headArr=@[@"The first head",@"The second head",@"The third head",@"The fourth head"];
  

}
//按钮的点击事件
- (IBAction)GoTuBay:(id)sender {
    
    self.BayBtn.selected=!self.BayBtn.selected;
    if (self.BayBtn.selected) {
//        self.bayViiew.backgroundColor=[UIColor redColor];
        self.tableView.hidden=YES;
        self.collectionDay.hidden=NO;
    }else {
        self.tableView.hidden=NO;
        self.collectionDay.hidden=YES;
    }
}

//关于collectionView的一些东西
-(void)collectionViewDay{
//    .初始化layout
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
//    设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    设置headerView的尺寸大小
    layout.headerReferenceSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-124);
//    该方法也可以设置itemSize
    layout.itemSize=CGSizeMake(110, 150);
    
//    初始化collectionView
    self.collectionDay=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 124, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-124) collectionViewLayout:layout];
    [self.view addSubview:self.collectionDay];
    
//    [self.collectionDay registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
     [self.collectionDay registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    
     [self.collectionDay registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    self.collectionDay.delegate=self;
    self.collectionDay.dataSource=self;
    
    self.collectionDay.backgroundColor=[UIColor whiteColor];
    
    
self.arr=@[@"http://img4.duitang.com/uploads/item/201506/18/20150618181443_Frv2V.jpeg",@"http://imgphoto.gmw.cn/attachement/jpg/site2/20120504/f04da22dd51e110d929e38.jpg",@"http://dynamic-image.yesky.com/740x-/uploadImages/2015/329/42/A040IVFHMXTV.jpg",@"http://i3.s2.dpfile.com/pc/wed/87a8c4289fa52bf74bc148a4c8da6990%28640c480%29/thumb.jpg",@"http://imga1.pic21.com/bizhi/140212/07423/s10.jpg",@"http://i1.s2.dpfile.com/pc/577ca5f02a2b820a1747bd55c3b49462%28740x2048%29/thumb.jpg",@"http://i1.s2.dpfile.com/pc/aa7154ccb9cc9e05d2a2428ce2ec417e(740x2048)/thumb.jpg",@"http://i2.s1.dpfile.com/pc/wed/7a1a44797c2ba347d38436773e8985f3(640c480)/thumb.jpg",@"http://qcloud.dpfile.com/wed/hzW0qjCDMTK11yO8vXPNjXDaXVk4UMN9nDvLX-tYQ2x-ejmT-iG_Go8fi3gIJIHgO3xc_zgr_wpcmvffXdGKhg.jpg"];

}
//设置tableview行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
//这就不多说了，再不知道我也没办法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    cell.textLabel.text=[NSString stringWithFormat:@"第%ld单元格",(long)indexPath.row];
 
    return cell;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TableCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row) {
//        设置随机颜色
        cell.textLabel.backgroundColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    }else{
        cell.textLabel.backgroundColor=[UIColor whiteColor];
    }
}

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.headArr.count;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.arr.count;
}

//这个你不知道可以撞墙了.没救了
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    cell.botlabel.text=[NSString stringWithFormat:@"第%ld张",(long)indexPath.row];
    cell.botlabel.hidden=NO;
    [cell.babyImageView sd_setImageWithURL:[NSURL URLWithString:self.arr[indexPath.row]]];
//    设置圆角
    cell.layer.masksToBounds=YES;
    cell.layer.cornerRadius=5.0;
    cell.layer.borderWidth=1.0;
    cell.layer.borderColor=[[UIColor blackColor]CGColor];
    
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 130);
}

//设置section的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor grayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
    label.text=[NSString stringWithFormat:@"%@",self.headArr[indexPath.section]];
    NSLog(@"____________%ld",(long)indexPath.section);
    label.font = [UIFont systemFontOfSize:20];
    [headerView addSubview:label];
    
    return headerView;

    
  

}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *msg = cell.botlabel.text;
    NSLog(@"%@",msg);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
