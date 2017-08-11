//
//  UIViewController+UIViewController_SliderVC.m
//  NavCreatsText
//
//  Created by gxtc on 17/1/19.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "UIViewController+UIViewController_SliderVC.h"
#import "SliderViewController.h"

@implementation UIViewController (UIViewController_SliderVC)

- (SliderViewController *)sliderViewController
{
    UIViewController *viewcontroller = (UIViewController *)self.parentViewController;
    
    while (viewcontroller) {
        if ([viewcontroller isKindOfClass:[SliderViewController class]]) {
            return (SliderViewController *)viewcontroller;
            
        }else if (viewcontroller.parentViewController && viewcontroller.parentViewController!=viewcontroller){
            viewcontroller = (UIViewController *)viewcontroller.parentViewController;
            
        }else{
            return nil;
        }
    }
    return nil;
}

@end
