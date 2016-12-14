//
//  TcLoginButton.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/18.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TcLoginButton.h"

@implementation TcLoginButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor {
    if (self = [super initWithFrame:frame]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setBackgroundColor:bgColor];
        self.layer.cornerRadius = self.height * .5;
        self.titleLabel.font = kFont14;
        self.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影颜色
        self.layer.shadowOffset = CGSizeMake(1, 1);// 阴影范围
        self.layer.shadowRadius = 4;// 阴影半径
        self.layer.shadowOpacity = .5;// 阴影透明度
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor {
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setBackgroundColor:bgColor];
        self.layer.cornerRadius = 40 * .5;
        self.titleLabel.font = kFont14;
        self.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影颜色
        self.layer.shadowOffset = CGSizeMake(1, 1);// 阴影范围
        self.layer.shadowRadius = 4;// 阴影半径
        self.layer.shadowOpacity = .5;// 阴影透明度
    }
    return self;
}

@end
