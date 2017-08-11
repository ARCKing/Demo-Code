//
//  subVC.m
//  CyhSlider
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "subVC.h"

@interface subVC ()

@end

@implementation subVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgimageview.image = [UIImage imageNamed:@"sub.jpg"];
    [self.view addSubview:bgimageview];
    NSLog(@"%@",self.showtext[0]);
    
    
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
