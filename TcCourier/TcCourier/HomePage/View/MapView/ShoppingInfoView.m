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


- (instancetype)initWithShopName:(NSString *)shopName tel:(NSString *)tel distance:(NSString *)distance address:(NSString *)address {
    if (self = [super init]) {
        _height = 0;
        
        self.backgroundColor = [UIColor whiteColor];
        CGFloat margin = 10;
        
        UIView *line = [UIView new];
        line.backgroundColor = kOrangeColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.top.and.left.equalTo(self);
            make.height.equalTo(@1);
        }];
        
        // 店铺名称
        UILabel *shopNameL = [UILabel new];
        [self addSubview:shopNameL];
        shopNameL.font = [UIFont systemFontOfSize:15];
        shopNameL.textColor = [UIColor orangeColor];
        shopNameL.text = shopName;
        [shopNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.top.equalTo(@(margin));
            
        }];
        _height += margin + [UILabel getHeightWithTitle:shopNameL.text font:shopNameL.font];
        
        // 商家电话
        UIFont *smallFont = [UIFont systemFontOfSize:13];
        UILabel *phoneL = [UILabel new];
        [self addSubview:phoneL];
        [phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopNameL);
            make.top.equalTo(shopNameL.mas_bottom).with.offset(margin);
        }];
        phoneL.font = smallFont;
        phoneL.text = [NSString stringWithFormat:@"商家电话:%@",tel];
        _height += margin + [UILabel getHeightWithTitle:phoneL.text font:phoneL.font];
        
        // 商家距离
        UILabel *disL = [UILabel new];
        [self addSubview:disL];
        [disL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopNameL);
            make.top.equalTo(phoneL.mas_bottom).with.offset(margin);
        }];
        disL.text = [NSString stringWithFormat:@"商家距离:%@米",distance];
        disL.font = smallFont;
        _height += margin + [UILabel getHeightWithTitle:disL.text font:disL.font];
        
        // 商家地址
        UILabel *addressTitle = [UILabel new];
        [self addSubview:addressTitle];
        addressTitle.text = [NSString stringWithFormat:@"商家地址:"];
        addressTitle.font = smallFont;
        [addressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopNameL);
            make.top.equalTo(disL.mas_bottom).with.offset(margin);
//            make.width.equalTo(@(kScreenWidth * 3 / 5));
            make.width.equalTo(@([UILabel getWidthWithTitle:addressTitle.text font:addressTitle.font]));
        }];
        
        
        
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:phoneBtn];
        [phoneBtn setBackgroundImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(phoneL);
            make.right.equalTo(@-40);
            make.width.and.height.equalTo(@35);
        }];
        [phoneBtn addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *navigateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:navigateBtn];
        [navigateBtn setBackgroundImage:[UIImage imageNamed:@"daohang"] forState:UIControlStateNormal];
        CGFloat naW = 40;
        [navigateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(phoneBtn);
            make.width.equalTo(@(naW));
            make.height.equalTo(@(naW / 78 * 29));
            make.centerY.equalTo(addressTitle);
        }];
        [navigateBtn addTarget:self action:@selector(navigate) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *addressL = [UILabel new];
        [self addSubview:addressL];
        addressL.numberOfLines = 0;
        addressL.font = smallFont;
        addressL.text = address;
        [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(addressTitle);
            make.width.equalTo(@150);
            make.left.equalTo(addressTitle.mas_right);
        }];
        
        _height += margin + [UILabel getHeightByWidth:150 title:addressL.text font:addressL.font] + margin;
        
        
//        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(_height));
//        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(_height));
        }];
        
    }
    return self;
}

// 拨号
- (void)phone {
    NSLog(@"bohao");
}

// 导航
- (void)navigate {
    NSLog(@"daohang");
}

@end
