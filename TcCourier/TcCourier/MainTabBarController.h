//
//  MainTabBarController.h
//  模仿简书自定义Tabbar（纯代码）
//
//  Created by 余钦 on 16/6/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewController.h"
#import "PersonCenterViewController.h"

@protocol MainTabBarControllerDelegate <NSObject>

- (void)setAddress:(NSString *)address;
//- (void)checkOrder;

@end


@interface MainTabBarController : UITabBarController

@property (nonatomic, assign) BOOL isPush;
@property(nonatomic, strong) HomePageViewController *homeVc;
@property (nonatomic, strong) PersonCenterViewController *personVC;

@property (nonatomic, assign) id<MainTabBarControllerDelegate> tabdelegate;


@end
