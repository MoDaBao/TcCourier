//
//  ShoppingInfoView.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/27.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ShoppingInfoView.h"

@implementation ShoppingInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [UIView new];
        line.backgroundColor = kOrangeColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.top.and.left.equalTo(self);
            make.height.equalTo(@1);
        }];
        
        UILabel *shopName = [UILabel new];
        [self addSubview:shopName];
        shopName.font = [UIFont systemFontOfSize:15];
        shopName.textColor = [UIColor orangeColor];
        shopName.text = @"肯德基";
        [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.top.equalTo(@10);
            
        }];
        
        UIFont *smallFont = [UIFont systemFontOfSize:13];
        UILabel *phoneL = [UILabel new];
        [self addSubview:phoneL];
        [phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopName);
            make.top.equalTo(shopName.mas_bottom).with.offset(10);
        }];
        phoneL.font = smallFont;
        phoneL.text = @"123123123";
        
        UILabel *disL = [UILabel new];
        [self addSubview:disL];
        [disL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopName);
            make.top.equalTo(phoneL.mas_bottom).with.offset(10);
        }];
        disL.text = @"100米";
        disL.font = smallFont;
        
        UILabel *addressL = [UILabel new];
        [self addSubview:addressL];
        addressL.text = @"XXXX";
        addressL.font = smallFont;
        [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopName);
            make.top.equalTo(disL.mas_bottom).with.offset(10);
        }];
        
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:phoneBtn];
        [phoneBtn setBackgroundImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(phoneL);
            make.right.equalTo(@-40);
            make.width.and.height.equalTo(@35);
        }];
        
        
        UIButton *navigateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:navigateBtn];
        [navigateBtn setBackgroundImage:[UIImage imageNamed:@"daohang"] forState:UIControlStateNormal];
        CGFloat naW = 40;
        [navigateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(phoneBtn);
            make.width.equalTo(@(naW));
            make.height.equalTo(@(naW / 78 * 29));
            make.centerY.equalTo(addressL);
        }];
        
        
    }
    return self;
}

@end
