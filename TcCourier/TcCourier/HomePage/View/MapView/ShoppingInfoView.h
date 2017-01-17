//
//  ShoppingInfoView.h
//  TcCourier
//
//  Created by M on 16/10/27.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingInfoView : UIView

@property (nonatomic, assign) CGFloat selfheight;// 视图自身的高度
@property (nonatomic, strong) UILabel *disL;

- (instancetype)initWithShopName:(NSString *)shopName tel:(NSString *)tel distance:(NSString *)distance address:(NSString *)address latitude:(NSString *)latitude longitude:(NSString *)longitude;


@end
