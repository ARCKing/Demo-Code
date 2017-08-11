//
//  AppDelegate.h
//  TimeLineStudy
//
//  Created by 张发行 on 16/9/20.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

