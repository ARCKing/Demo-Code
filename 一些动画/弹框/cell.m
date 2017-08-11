//
//  cell.m
//  弹框
//
//  Created by root on 16/10/31.
//  Copyright © 2016年 root. All rights reserved.
//

#import "cell.h"

@implementation cell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 50)];
        [self.contentView addSubview:self.img];
        self.img.image =[UIImage imageNamed:@"00.jpg" ];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 200, 20)];
        [self.contentView addSubview:self.title];
        self.title.numberOfLines = 0;
        self.title.font = [UIFont systemFontOfSize:14];
            
        
    }


    return self;
}

- (void)loadData:(NSString *)str{


    self.title.text = str;
    
    NSLog(@"======>%@",self.title.text);
    
     CGRect titlehigh = [str boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    CGRect fram = self.title.frame;

    fram.size.height = titlehigh.size.height;

    self.title.frame = fram;
    NSLog(@"%@",self.title.text);

}



@end
