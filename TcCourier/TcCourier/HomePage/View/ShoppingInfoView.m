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
        shopName.text = @"肯德基";
        [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
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
        [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopName);
            make.top.equalTo(disL.mas_bottom).with.offset(10);
        }];
        addressL.text = @"XXXX";
        addressL.font = smallFont;
        
    }
    return self;
}

@end
