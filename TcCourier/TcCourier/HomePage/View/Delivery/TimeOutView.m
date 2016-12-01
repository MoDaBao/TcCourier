//
//  TimeOutView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/30.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TimeOutView.h"

@implementation TimeOutView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadTimeOut:(NSString *)timeOut {
    UILabel *titleL = [UILabel new];
    [self addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(@5);
    }];
    titleL.font = kFont14;
    titleL.text = @"超时赔付:";
    
    UILabel *timeOutL = [UILabel new];
    [self addSubview:timeOutL];
    [timeOutL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(@-5);
    }];
    timeOutL.font = kFont14;
    [self setAttStrWithlabel:timeOutL title:@"剩余时间:" sum:timeOut];
}

/**
 设置价格富文本
 
 @param label 需要设置富文本的标签对象
 @param title 例如 订单总额:
 @param sum 例如 ￥10.00
 */
- (void)setAttStrWithlabel:(UILabel *)label title:(NSString *)title sum:(NSString *)sum {
    NSString *str = [NSString stringWithFormat:@"%@%@",title, sum];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.80 green:0.15 blue:0.15 alpha:1.00] range:NSMakeRange(title.length,str.length - title.length)];
    label.attributedText = attStr;
}

@end