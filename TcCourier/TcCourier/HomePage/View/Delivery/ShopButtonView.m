//
//  ShopButtonView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/30.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ShopButtonView.h"

@implementation ShopButtonView

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
    CGFloat height = 0;
    CGFloat margin = 5;
    UIView *temp = nil;
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
            make.right.equalTo(@(margin));
        }];
        addressL.font = [UIFont systemFontOfSize:12];
        addressL.text = [NSString stringWithFormat:@"地址:%@",storeInfoModel.address];
        height += margin + [UILabel getHeightByWidth:kScreenWidth - 30 title:addressL.text font:addressL.font];
        
        UIImageView *jiantou = [UIImageView new];
        [self addSubview:jiantou];
        CGFloat jiantouW = 8;
        [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-margin));
            // 17 X 29
            make.width.equalTo(@(jiantouW));
            make.height.equalTo(@(jiantouW * 1.0 / 17 * 29));
            make.top.equalTo(addressL.mas_top).offset(-jiantouW * 1.0 / 17 * 29  * .5);
        }];
        jiantou.image = [UIImage imageNamed:@"youbianjian"];
        
        // 备注
        UILabel *remarkL = [UILabel new];
        [self addSubview:remarkL];
        [remarkL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon);
            make.top.equalTo(addressL.mas_bottom).offset(margin);
            make.right.equalTo(@(margin));
        }];
        remarkL.font = kFont14;
        remarkL.numberOfLines = 0;
        remarkL.text = [NSString stringWithFormat:@"备注:%@",storeInfoModel.remark];
        height += margin + [UILabel getHeightByWidth:kScreenWidth - 30 title:remarkL.text font:remarkL.font];
        
        // 配送按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(remarkL.mas_bottom).offset(margin);
            make.height.equalTo(@35);
            make.width.equalTo(@150);
        }];
        btn.layer.cornerRadius = margin;
        [btn setTitle:storeInfoModel.orderStatus forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:0.93 green:0.33 blue:0.31 alpha:1.00]];// 暂时先设置这个颜色
        btn.titleLabel.font = kFont14;
        
        height += margin + 35;
        
        if (storeInfoModel != [storeInfoArray lastObject]) {
            // 分割线
            float sortaPixel = 1.0 / [UIScreen mainScreen].scale;
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor blackColor];
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(self);
                make.height.equalTo(@(sortaPixel));
                make.top.equalTo(btn.mas_bottom).offset(5);
            }];
            temp = line;
        }
        
        height += margin;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    
//    self.backgroundColor = [UIColor orangeColor];
}


@end
