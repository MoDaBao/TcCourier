//
//  UIViewController+GetCurrentViewController.m
//  TcCourier
//
//  Created by M on 2016/12/22.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "UIViewController+GetCurrentViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"

@implementation UIViewController (GetCurrentViewController)

+ (UIViewController *)getCurrentViewController {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    MainTabBarController *tabVC = (MainTabBarController *)appdelegate.window.rootViewController;
    if (tabVC.selectedIndex == 0) {
        return tabVC.homeVc.navigationController.viewControllers.lastObject;
    } else {
        return tabVC.personVC.navigationController.viewControllers.lastObject;
    }
}

@end
