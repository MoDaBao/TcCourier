//
//  AppDelegate.h
//  TcCourier
//
//  Created by 莫大宝 on 16/10/13.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppDelegateSetAddressDelegate <NSObject>

- (void)setAddress:(NSString *)address;

@end
//c1c6d53368706279976bb587 配送端测试key
//4c84c1932d79c4740d3b9d78 配送端key
static NSString *appKey = @"c1c6d53368706279976bb587";
static NSString *channel = @"App Store";
static BOOL isProduction = FALSE;// 开发环境

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) id<AppDelegateSetAddressDelegate> addressDelegate;


@end

