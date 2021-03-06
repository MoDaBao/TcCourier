//
//  ReceiverAddressView.m
//  TcCourier
//
//  Created by M on 2016/11/29.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ReceiverAddressView.h"
#import "ReceiverAddressViewController.h"
#import "DeliveryViewController.h"
#import "WaitReceiveOrderViewController.h"

@interface ReceiverAddressView ()

@property (nonatomic, strong) AddressInfoModel *addressInfoModel;
@property (nonatomic, copy) NSString *orderNumber;

@end

@implementation ReceiverAddressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadReceiverAddress:(AddressInfoModel *)addressInfoModel orderNumber:(NSString *)orderNumber {

//    _orderNumber = orderNumber;
    _addressInfoModel = addressInfoModel;

    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    // 图标
    UIImageView *icon = [UIImageView new];
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.and.height.equalTo(@15);
    }];
    icon.image = [UIImage imageNamed:@"shouhuodizhi"];
    
    // 箭头
    UIImageView *jiantou = [UIImageView new];
    [self addSubview:jiantou];
    CGFloat jiantouW = 8;
    [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-5);
        // 17 X 29
        make.width.equalTo(@(jiantouW));
        make.height.equalTo(@(jiantouW * 1.0 / 17 * 29));
        make.centerY.equalTo(self.mas_centerY);
    }];
    jiantou.image = [UIImage imageNamed:@"youbianjian"];
    
    // 地址
    UILabel *addressL = [UILabel new];
    [self addSubview:addressL];
    [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(icon.mas_centerY);
        make.left.equalTo(icon.mas_right).offset(5);
        make.right.equalTo(jiantou.mas_left);
    }];
    addressL.font = kFont14;
    addressL.text = [NSString stringWithFormat:@"收货地址:%@%@",addressInfoModel.address, addressInfoModel.detail_addr];
//    addressL.backgroundColor = [UIColor randomColor];
    
    // 跳转至地图按钮
    UIButton *btn = [UIButton new];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
//    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click:(UIButton *)btn {
    ReceiverAddressViewController *receiverVC = [[ReceiverAddressViewController alloc] init];
//    receiverVC.orderNumber = _orderNumber;
    receiverVC.addressInfoModel = _addressInfoModel;
    
    UIViewController *vc = [UIViewController getCurrentViewController];
    [vc.navigationController pushViewController:receiverVC animated:YES];
}

@end
