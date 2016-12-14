//
//  ShoppingInfoView.h
//  TcCourier
//
//  Created by 莫大宝 on 16/10/27.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingInfoView : UIView

@property (nonatomic, assign) CGFloat height;// 视图自身的高度

- (instancetype)initWithShopName:(NSString *)shopName tel:(NSString *)tel distance:(NSString *)distance address:(NSString *)address;


@end
