//
//  ViewController.m
//  弹框
//
//  Created by root on 16/10/28.
//  Copyright © 2016年 root. All rights reserved.
//

#import "ViewController.h"
#import "cell.h"
#import "imgCell.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView * vv;
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,retain)cell * cell;

@property(nonatomic,strong)NSArray * strArray;

@property(nonatomic,strong)NSArray * imgArray;
@property(nonatomic,strong)NSArray * colourArray;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSArray * readArray;
@property(nonatomic,strong)NSArray * timeArray;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.strArray = @[@"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",@"BB",@"CCCCCCCC",@"DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD",@"EEEEEE",@"FFFFF",@"GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG",@"HHHHHHHHHHHHHHH",@"IIIIIIIIII",@"JJJ"];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    headView.backgroundColor = [UIColor purpleColor];
    
    self.tableView.tableHeaderView = headView;
    
    [self.view addSubview:self.tableView];
    
//    self.tableView.rowHeight = 150;
//
    
    
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, 180)];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 300, 150)];
//    label.text = @"Hello world! Hello world!Hello world! Hello world! Hello world! Hello world! Hello world! Hello world!Hello world! Hello world! Hello world! Hello world! Hello world! Helloworld!";
//    //背景颜色为红色
//    label.backgroundColor = [UIColor redColor];
//    //设置字体颜色为白色
//    label.textColor = [UIColor whiteColor];
//    //文字居中显示
//    label.textAlignment = NSTextAlignmentCenter;
//    //自动折行设置
//    label.lineBreakMode = NSLineBreakByClipping;
//    label.numberOfLines = 0;
//    
//    [self.view addSubview:label];
    
//    [self timer];
    
    
    UIImage * image1 = [UIImage imageNamed:@"12.jpg"];
    UIImage * image2 = [UIImage imageNamed:@"11.jpg"];
    UIImage * image3 = [UIImage imageNamed:@"00.jpg"];
    
    UIColor * colour1 = [UIColor orangeColor];
    UIColor * colour2 = [UIColor purpleColor];
    UIColor * colour3 = [UIColor brownColor];

    NSArray * colourArray = @[colour1,colour2,colour3,colour1,colour2,colour3,colour1,colour2,colour3];
    
    NSArray * imgArray = @[image1,image2,image3,image3,image2,image1,image2,image3,image1];
    
    NSArray * titleArray = @[@"木头",@"西瓜",@"菜刀",@"洗脸",@"洗澡",@"好人",@"坏人",@"汽车",@"火车",@"卡车"];
    NSArray * timeArraay = @[@"000",@"100",@"100",@"200",@"300",@"400",@"500",@"600",@"700",@"800",@"900"];
    
    NSArray * readArray = @[@"1232423",@"3546",@"23",@"4657",@"46246",@"464",@"3467",@"5747",@"2356",@"4768"];


    self.colourArray = colourArray;
    self.imgArray = imgArray;
    self.titleArray = titleArray;
    self.timeArray = timeArraay;
    self.readArray = readArray;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        
        return 2;
        
    }else if (section == 2){
    
        return 8;
    }else{
        
        return self.strArray.count;
        
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    self.cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ldcell"]];
    
    UITableViewCell * advCell = [tableView dequeueReusableCellWithIdentifier:@"advCell"];

    if (advCell == nil) {
        advCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"advCell"];
    }
    
    if (self.cell == nil) {
        self.cell = [[cell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[NSString stringWithFormat:@"ldcell"]];
    }
    
   
    
    if (indexPath.section == 1) {
        
    
    
        if (indexPath.row == 0) {
        
            self.cell.tag = 100;
            
            [self.cell loadData:self.strArray[arc4random()%9 + 1]];
        

        }else if (indexPath.row == 1){

            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/4, SCREEN_W/5)];
            imageView.center =CGPointMake(SCREEN_W/8 + 10, SCREEN_W/8);
            [advCell.contentView addSubview:imageView];
            imageView.backgroundColor = [UIColor redColor];
        
            UILabel * labrl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10, CGRectGetMinY(imageView.frame), SCREEN_W * 2/3, 30)];
            [advCell.contentView addSubview:labrl];
            labrl.numberOfLines = 0;
            labrl.text = @"爱的色放广东省郭德纲";
            labrl.font = [UIFont systemFontOfSize:14];
        
        
        
            return advCell;

    
        }else{
    
    
            [self.cell loadData:self.strArray[indexPath.row]];
    
        }
    
            return self.cell;
        
    }else if(indexPath.section == 0){
    
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cells"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"123";
        cell.detailTextLabel.text = @"ABCDEFG";
        
        return cell;
    }else{
    
        imgCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ldcell",indexPath.row]];
        if (cell == nil) {
            
            cell = [[imgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[NSString stringWithFormat:@"%ldcell",indexPath.row]];
            
        }else{
        
            
            
        }
        
        [cell addData:self.imgArray[indexPath.row] andTitle:self.titleArray[indexPath.row] andTime:self.timeArray[indexPath.row] andRead:self.readArray[indexPath.row] andColour:self.colourArray[indexPath.row]];
                
        return cell;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

   
    if (indexPath.row == 0) {
        CGFloat h = self.cell.title.frame.size.height;
        
        return h + 50 + 30;
        
    }else if(indexPath.row == 1){
    
    return SCREEN_W/4;
        
    }else{
    
        return 120;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
        
        NSLog(@"%ld ==>",indexPath.section);
    }else{
    
        NSLog(@"%ld ++>",indexPath.section);
    }
    
    
}


//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;//section头部高度
}


//section头部视图
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor redColor];
    return view ;
}


//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
//section底部视图
- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor greenColor];
    return view;
}







- (void)timer{

    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reloadCell)  userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];


}



- (void)reloadCell{
   
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationLeft];

//    [self.tableView reloadData];
    
}

@end
