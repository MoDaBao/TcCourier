//
//  ContantHeader.h
//  TcCourier
//
//  Created by M on 16/10/13.
//  Copyright © 2016年 dabao. All rights reserved.
//

#ifndef ContantHeader_h
#define ContantHeader_h


#define kScreenWidth [UIScreen mainScreen].bounds.size.width // 屏幕宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height // 屏幕高度
#define kStatusHeight 20 // 状态条高度
#define kNavigationBarHeight 64 // 导航栏高度+状态条的高度
#define KTabBarHeight 44 // 标签栏高度
#define kBaseWordHeight [UILabel getWidthWithTitle:@"的" font:[UIFont systemFontOfSize:14]];//14号字体的中文的高度

#define kOrangeColor [UIColor colorWithRed:252 / 255.0 green:135 / 255.0 blue:3 / 255.0 alpha:1.0] // 整体橙色
#define kBGGary [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1.0] // 灰色背景
#define kFont14 [UIFont systemFontOfSize:14] //大小为14的字体对象

#define kScaleForWidth [UIScreen mainScreen].bounds.size.width / 375.0 //以iPhone6的尺寸为基准的宽比
#define kScaleForHeight [UIScreen mainScreen].bounds.size.height / 667.0 //以iPhone6的尺寸为基准的高比

#define kHeartWidth 24// 爱心图片的宽度
#define kHeartHeight 18// 爱心图片的高度

#define REQUEST_URL @"https://waimai.tzouyi.com/" //接口地址

#endif /* ContantHeader_h */
