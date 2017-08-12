//
//  CollectionViewCell.m
//  SnapshotViewAfterScreenUpdatesAnimation
//
//  Created by gxtc on 2017/8/9.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon_image;

@property (weak, nonatomic) IBOutlet UILabel *titleLabrl;


@end


@implementation CollectionViewCell

- (IBAction)stateBtAction:(id)sender {
    
    
    if (self.cellSelectSateBK) {
        
        self.cellSelectSateBK(self);
    }
    
}


   


- (void)setModel:(ChannelIteamModel *)model{

    _model = model;
    
    self.icon_image.image = [UIImage imageNamed:model.iconName];
    self.titleLabrl.text = model.title;

    
    if (self.isEditing) {
        
        self.stateBt.hidden = NO;
        
        self.BGView.layer.borderWidth = 0.5;
        self.BGView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        Status stats = [model.state integerValue];
        
        self.state = stats;
        
        if (stats == Status_PlusSign) {
            
            [self.stateBt setImage:[UIImage imageNamed:@"icon_s_select"] forState:UIControlStateNormal];

        }else if (stats == Status_UnPlusSign){

            [self.stateBt setImage:[UIImage imageNamed:@"icon_u_select"] forState:UIControlStateNormal];

        }else if (stats == Status_MinusSign){

            [self.stateBt setImage:[UIImage imageNamed:@"icon_jian"] forState:UIControlStateNormal];

        }
        
    }else{
    
        self.stateBt.hidden = YES;
        
        self.BGView.layer.borderWidth = 0.0;
    }
    
}

@end
