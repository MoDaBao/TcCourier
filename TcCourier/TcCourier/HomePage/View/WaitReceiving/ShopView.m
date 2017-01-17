//
//  ShopView.m
//  TcCourier
//
//  Created by M on 2016/12/6.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ShopView.h"
#import "StoreInfoModel.h"
#import "ShopAddressViewController.h"
#import "WaitReceiveOrderViewController.h"

@interface ShopView ()

@property (nonatomic, strong) NSMutableArray *storeInfoArray;

@end

@implementation ShopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadViewWithStoreInfoArray:(NSArray *)storeInfoArray {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    _storeInfoArray = storeInfoArray;
    CGFloat height = 0;
    CGFloat margin = 5;
    UIView *temp = nil;
    NSInteger btntag = 5000;
    CGFloat jiantouW = 8;
    for (StoreInfoModel *storeInfoModel in storeInfoArray) {
        UIImageView *icon = [UIImageView new];
        [self addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            if (temp) {
                make.top.equalTo(temp.mas_bottom).offset(margin);
            } else {
                make.top.equalTo(@(margin));
            }
            make.left.equalTo(@(margin));
            make.width.and.height.equalTo(@15);
        }];
        icon.image = [UIImage imageNamed:@"dianpuxinxi"];
        height += 15 + margin;
        
        // 店铺名称
        UILabel *shopNameL = [UILabel new];
        [self addSubview:shopNameL];
        [shopNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon.mas_centerY);
            make.left.equalTo(icon.mas_right).offset(margin);
        }];
        shopNameL.font = kFont14;
        shopNameL.text = storeInfoModel.store_name;
        
        // 地址
        UILabel *addressL = [UILabel new];
        [self addSubview:addressL];
        [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon);
            make.top.equalTo(icon.mas_bottom).offset(margin);
            make.right.equalTo(self).offset(-(margin + jiantouW));
        }];
        addressL.font = [UIFont systemFontOfSize:12];
        addressL.text = [NSString stringWithFormat:@"地址:%@",storeInfoModel.address];
        addressL.numberOfLines = 0;
        height += margin + [UILabel getHeightByWidth:kScreenWidth - 38 title:addressL.text font:addressL.font];
        
        // 箭头
        UIImageView *jiantou = [UIImageView new];
        [self addSubview:jiantou];
        [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-margin));
            // 17 X 29
            make.width.equalTo(@(jiantouW));
            make.height.equalTo(@(jiantouW * 1.0 / 17 * 29));
            make.centerY.equalTo(addressL.mas_centerY);
        }];
        jiantou.image = [UIImage imageNamed:@"youbianjian"];
        
        // 备注
        UILabel *remarkL = [UILabel new];
        [self addSubview:remarkL];
        [remarkL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon);
            make.top.equalTo(addressL.mas_bottom).offset(margin);
            make.right.equalTo(jiantou.mas_right);
        }];
        remarkL.font = kFont14;
        remarkL.numberOfLines = 0;
        remarkL.text = [NSString stringWithFormat:@"备注:%@",storeInfoModel.remark];
        height += margin + [UILabel getHeightByWidth:kScreenWidth - 30 title:remarkL.text font:remarkL.font];
        
        float sortaPixel = 1.0 / [UIScreen mainScreen].scale;
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor blackColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.height.equalTo(@(sortaPixel));
            make.top.equalTo(remarkL.mas_bottom).offset(5);
        }];
        temp = line;
        
//        height += margin + sortaPixel;
        height += margin + 1;
        
        
        // 地址跳转按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
            make.top.equalTo(icon.mas_top);
            make.left.and.right.equalTo(self);
            make.bottom.equalTo(line.mas_bottom);
        }];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = btntag++;
        
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    
}

- (void)click:(UIButton *)btn {
    //    StoreInfoModel *store = _storeInfoArray[btn.tag - 2000];
    NSLog(@"跳转至地图页面显示商家地址");
    
    ShopAddressViewController *shopAddressVC = [[ShopAddressViewController alloc] init];
    shopAddressVC.storeInfoModel = self.storeInfoArray[btn.tag - 5000];
    
    
    WaitReceiveOrderViewController *waitVC = (WaitReceiveOrderViewController *)[UIViewController getCurrentViewController];
    [waitVC.navigationController pushViewController:shopAddressVC animated:YES];
}

@end
