//
//  TotalAmountAndPaymentView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/29.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TotalAmountAndPaymentView.h"

@implementation TotalAmountAndPaymentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadTotalAmount:(NSString *)total payment:(NSString *)payment {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView *icon = [UIImageView new];
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.and.height.equalTo(@15);
    }];
    icon.image = [UIImage imageNamed:@"fukuanfangshi"];
    
    UILabel *totalL = [UILabel new];
    [self addSubview:totalL];
    [totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(icon.mas_centerY);
        make.left.equalTo(icon.mas_right).offset(5);
    }];
    totalL.font = kFont14;
    //        totalL.text = [NSString stringWithFormat:@"订单总额:%@",total];
    [self setAttStrWithlabel:totalL title:@"订单总额:" sum:[NSString stringWithFormat:@"￥%@",total]];
    
    
    UILabel *paymentL = [UILabel new];
    [self addSubview:paymentL];
    [paymentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(totalL.mas_centerY);
        make.right.equalTo(@-5);
    }];
    paymentL.font = kFont14;
    paymentL.text = [NSString stringWithFormat:@"支付方式:%@",payment];
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
