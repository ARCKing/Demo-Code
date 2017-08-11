//
//  CyhSliderVC.h
//  CyhSlider
//
//  Created by Macx on 16/8/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  侧滑菜单协议
 */
@protocol pushdelegate <NSObject>
/**
 *  左侧滑控制器跳转代理方法
 *
 *  @param trag <#trag description#>
 */
- (void)pushsubVC:(id)trag;

@end
typedef void(^hidenMainVc)(NSString *);
@interface CyhSliderVC : UIViewController
@property (nonatomic , strong)UIViewController * Mainvc;
@property (nonatomic , strong)UIViewController * Leftvc;
@property (nonatomic , copy)hidenMainVc hidenBlickde;
@property (nonatomic , weak)id <pushdelegate> pudelegate;
//@property (nonatomic , strong)UIViewController * Rightvc;
/**
 *  初始化单例
 *
 *  @return <#return value description#>
 */
+ (CyhSliderVC *)initCyhslider;
/**
 *  添加主页和左侧滑控制器
 *
 *  @param Mainvc <#Mainvc description#>
 *  @param LeftVC <#LeftVC description#>
 */
- (void)addMainVC:(UIViewController *)Mainvc addLeftVC:(UIViewController *)LeftVC;
/**
 *  添加主页左上角侧滑按钮
 *
 *  @param Itemtitle <#Itemtitle description#>
 *  @param Itemcolor <#Itemcolor description#>
 *  @param image     <#image description#>
 *  @param trag      <#trag description#>
 */
- (void)AddSliderLeftItem:(NSString *)Itemtitle Itemtitlecolor:(UIColor *)Itemcolor UImage:(UIImage *)image Trag:(UIViewController *)trag;
/**
 *  左侧滑控制器跳转方法
 *
 *  @param trag <#trag description#>
 */
- (void)pushSubvc:(id)trag;

@end
