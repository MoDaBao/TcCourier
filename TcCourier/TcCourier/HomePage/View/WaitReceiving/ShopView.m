//
//  ShopView.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ShopView.h"

@implementation ShopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame shopName:(NSString *)shopName address:(NSString *)address {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 创建图标
        CGFloat margin = 12;
        CGFloat iconW = 15;
        CGFloat iconH = iconW;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, iconW, iconH)];
        icon.image = [UIImage imageNamed:@"dianpuxinxi"];
        [self addSubview:icon];
        
        // 商家名称标签
        UIFont *shopNameFont = kFont14;
        CGFloat shopW = [UILabel getWidthWithTitle:shopName font:shopNameFont];
        CGFloat showH = [UILabel getHeightWithTitle:shopName font:shopNameFont];
        UILabel *shopNameL = [[UILabel alloc] initWithFrame:CGRectMake(icon.x + icon.width + margin * 3 * .5, icon.y + icon.height * .5 - showH * .5, shopW, showH)];
        shopNameL.font = shopNameFont;
        shopNameL.text = shopName;
        [self addSubview:shopNameL];
        
        // 地址标签
        UIFont *addressFont = [UIFont systemFontOfSize:12];
        CGFloat addressW = [UILabel getWidthWithTitle:address font:addressFont];
        CGFloat addressH = [UILabel getHeightWithTitle:address font:addressFont];
        UILabel *addressL = [[UILabel alloc] initWithFrame:CGRectMake(margin, icon.y + icon.height + margin, addressW, addressH)];
        addressL.font = addressFont;
        addressL.text = address;
        [self addSubview:addressL];
        
        CGFloat rightW = 10;
        CGFloat rightH = rightW / 17 * 29;
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - rightW - 10, (self.height - rightH) * .5, rightW, rightH)];
        rightView.image = [UIImage imageNamed:@"youbianjian"];
        [self addSubview:rightView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        
    }
    return self;
}


@end
