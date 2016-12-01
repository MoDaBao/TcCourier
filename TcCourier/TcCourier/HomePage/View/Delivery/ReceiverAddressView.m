//
//  ReceiverAddressView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/29.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ReceiverAddressView.h"

@implementation ReceiverAddressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadReceiverAddress:(NSString *)address {
    UIImageView *icon = [UIImageView new];
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.and.height.equalTo(@15);
    }];
    icon.image = [UIImage imageNamed:@"shouhuodizhi"];
    
    UILabel *addressL = [UILabel new];
    [self addSubview:addressL];
    [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(icon.mas_centerY);
        make.left.equalTo(icon.mas_right).offset(5);
    }];
    addressL.font = kFont14;
    addressL.text = [NSString stringWithFormat:@"收货人地址:%@",address];
}

@end
