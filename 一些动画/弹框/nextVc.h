//
//  nextVc.h
//  弹框
//
//  Created by root on 16/10/31.
//  Copyright © 2016年 root. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fourVc.h"

typedef  void (^nextBlock) (void);

@interface nextVc : UIViewController
@property(nonatomic,strong)fourVc * vc;

@property(nonatomic,copy)nextBlock nt;
@end
