//
//  RunFeeAndTiFeeView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/30.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "RunFeeAndTiFeeView.h"

@implementation RunFeeAndTiFeeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadRunFee:(NSString *)runFee tiFee:(NSString *)tiFee {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel *runFeeL = [UILabel new];
    [self addSubview:runFeeL];
    [runFeeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(@5);
    }];
    runFeeL.font = kFont14;
    [self setAttStrWithlabel:runFeeL title:@"跑腿费:" sum:[NSString stringWithFormat:@"￥%@",runFee]];
    
    UILabel *tiFeeL = [UILabel new];
    [self addSubview:tiFeeL];
    [tiFeeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(@-5);
    }];
    tiFeeL.font = kFont14;
    [self setAttStrWithlabel:tiFeeL title:@"跑腿提成:" sum:[NSString stringWithFormat:@"￥%@",tiFee]];
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
