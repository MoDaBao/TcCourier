//
//  ShoppingInfoView.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/27.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ShoppingInfoView.h"

@interface ShoppingInfoView ()

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *endlatitude;
@property (nonatomic, copy) NSString *endlongitude;
@property (nonatomic, copy) NSString *address;

@end

@implementation ShoppingInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithShopName:(NSString *)shopName tel:(NSString *)tel distance:(NSString *)distance address:(NSString *)address latitude:(NSString *)latitude longitude:(NSString *)longitude {
    if (self = [super init]) {
        _selfheight = 0;
        
        _phoneNumber = tel;
        _endlatitude = latitude;
        _endlongitude = longitude;
        _address = address;
        
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
            make.left.equalTo(@(30 * kScaleForWidth));
            make.top.equalTo(@(margin));
            
        }];
        _selfheight += margin + [UILabel getHeightWithTitle:shopNameL.text font:shopNameL.font];
        
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
        _selfheight += margin + [UILabel getHeightWithTitle:phoneL.text font:phoneL.font];
        
        // 商家距离
        _disL = [UILabel new];
        [self addSubview:_disL];
        [_disL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopNameL);
            make.top.equalTo(phoneL.mas_bottom).with.offset(margin);
        }];
        _disL.text = [NSString stringWithFormat:@"商家距离:%@米",distance];
        _disL.font = smallFont;
        _selfheight += margin + [UILabel getHeightWithTitle:_disL.text font:_disL.font];
        
        // 商家地址
        UILabel *addressTitle = [UILabel new];
        [self addSubview:addressTitle];
        addressTitle.text = [NSString stringWithFormat:@"商家地址:"];
        addressTitle.font = smallFont;
        [addressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopNameL);
            make.top.equalTo(_disL.mas_bottom).with.offset(margin);
//            make.width.equalTo(@(kScreenWidth * 3 / 5));
            make.width.equalTo(@([UILabel getWidthWithTitle:addressTitle.text font:addressTitle.font]));
        }];
        
        
        
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:phoneBtn];
        [phoneBtn setBackgroundImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(phoneL);
            make.right.equalTo(@(-30 * kScaleForWidth));
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
        
        _selfheight += margin + [UILabel getHeightByWidth:150 title:addressL.text font:addressL.font] + margin;
        
        
//        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(_height));
//        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(_selfheight));
        }];
        
    }
    return self;
}

// 拨号
- (void)phone {
    NSLog(@"bohao");
    if (_phoneNumber.length > 0) {
        NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",self.phoneNumber]; //而这个方法则打电话前先弹框  是否打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前商家未提供电话号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    

}

// 导航
- (void)navigate {
    NSLog(@"daohang");
    
    
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=TcCourier&sid=BGVIS1&slat=%@&slon=%@&sname=我的位置&did=BGVIS2&dlat=%@&dlon=%@&dname=%@&dev=0&t=0",[[TcCourierInfoManager shareInstance] getLatitude], [[TcCourierInfoManager shareInstance] getLongitude], _endlatitude, _endlongitude, _address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *myLocationScheme = [NSURL URLWithString:urlString];

    if ([[UIApplication sharedApplication] canOpenURL:myLocationScheme]) {
        if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
            //iOS10以后,使用新API
            [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) {
                NSLog(@"scheme调用结束");
            }];
        } else {
            //iOS10以前,使用旧API
            [[UIApplication sharedApplication] openURL:myLocationScheme];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先安装高德地图" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

@end
