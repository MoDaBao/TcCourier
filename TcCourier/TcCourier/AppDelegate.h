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

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) id<AppDelegateSetAddressDelegate> addressDelegate;


@end

