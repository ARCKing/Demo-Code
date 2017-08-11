//
//  lbl_IntroPrizView.h
//  Spinner
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 筒子家族. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseViewBlock)(void);

@interface lbl_IntroPrizView : UIView

@property (nonatomic,copy)   CloseViewBlock block;
@property (nonatomic,strong) NSString       *introText;

@end
