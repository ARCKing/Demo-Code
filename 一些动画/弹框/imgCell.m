//
//  imgCell.m
//  弹框
//
//  Created by gxtc on 16/12/28.
//  Copyright © 2016年 root. All rights reserved.
//

#import "imgCell.h"

@interface imgCell()
@property (nonatomic,strong)UIImageView * imgView1;
@property (nonatomic,strong)UIImageView * imgView2;
@property (nonatomic,strong)UIImageView * imgView3;

@property (nonatomic,strong)UILabel * title;
@property (nonatomic,strong)UILabel * time;
@property (nonatomic,strong)UILabel * read;

@property (nonatomic,strong)NSString * timestr;
@property (nonatomic,strong)NSString * titlestr;
@property (nonatomic,strong)NSString * readstr;
@property (nonatomic,strong)UIImage * imges;
@property (nonatomic,strong)UIColor * colours;

@end

@implementation imgCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }

    return self;
}


- (void)drawRect:(CGRect)rect{

    
        self.imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
        
        [self.contentView addSubview:self.imgView1];
        
    
        
        self.imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(60, 50, 50, 50)];
        [self.contentView addSubview:self.imgView2];

    
    
        self.imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(120, 50, 50, 50)];
        [self.contentView addSubview:self.imgView3];

    
    
    
  
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(5, 60, 50, 20)];
        [self.contentView addSubview:self.time];
    

   
        self.read = [[UILabel alloc]initWithFrame:CGRectMake(60, 60, 50, 20)];
        [self.contentView addSubview:self.read];
    
    
    
          self.title = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 50, 20)];
        [self.contentView addSubview:self.title];
    
    
    self.title.text = self.titlestr;
    self.time.text = self.timestr;
    self.read.text = self.readstr;
    
    
}


- (void)addData:(UIImage *)img andTitle:(NSString *)title andTime:(NSString *)time
        andRead:(NSString *)read andColour:(UIColor *)colour{

    self.imges = img;
    self.timestr = time;
    self.readstr = read;
    self.titlestr = title;
    self.colours = colour;

}









- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
