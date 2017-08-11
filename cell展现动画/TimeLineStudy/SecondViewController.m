//
//  SecondViewController.m
//  TimeLineStudy
//
//  Created by MX007 on 16/9/20.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "SecondViewController.h"

#import "SecondCell.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self doCellAnimationWithAnimationStyle:UITableViewCellDisplayAnimationStyleScale onTheView:cell];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifiler = @"Cell";
    SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifiler];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SecondCell" owner:nil options:nil][0];
        cell.backgroundColor = [UIColor cyanColor];
    }
    cell.imageVi.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",indexPath.row%4]];
    return cell;
}


//cell显示动画
- (void)doCellAnimationWithAnimationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle onTheView:(UIView *)view
{
    
    switch (animationStyle) {
        case UITableViewCellDisplayAnimationStyleFade:
        {
            view.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                view.alpha = 1;
            }];
        }
            break;
        case UITableViewCellDisplayAnimationStyleScale:
        {
            view.layer.transform = CATransform3DMakeScale(0.2, 0.2, 1);
            [UIView animateWithDuration:0.5 animations:^{
                view.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }];
        }
            break;
        case UITableViewCellDisplayAnimationStylePosition:
        {
            view.transform = CGAffineTransformTranslate(view.transform, -[UIScreen mainScreen].bounds.size.width/2, 0);
            [UIView animateWithDuration:0.5 animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
            
        }
            break;
        case UITableViewCellDisplayAnimationStyleRotateX:
        {
            view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 1, 0, 0);
            [UIView animateWithDuration:0.5 animations:^{
                view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 1, 0, 0);
            }];

        }
            break;
        case UITableViewCellDisplayAnimationStyleRotateY:
        {
            view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 0, 1, 0);
            [UIView animateWithDuration:0.5 animations:^{
                view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 0, 1, 0);
            }];
            
        }
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
