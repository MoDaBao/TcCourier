//
//  FoodListView.m
//  TcCourier
//
//  Created by M on 2016/11/22.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "FoodListView.h"

@implementation FoodListView

- (void)loadDataWithFoodArray:(NSArray *)foodArray {
    // 临时变量
    UILabel *tempL = nil;
    for (FoodModel *foodModel in foodArray) {
        // 餐品名称
        UILabel *foodNameL = [UILabel new];
        [self addSubview:foodNameL];
        foodNameL.font = kFont14;
        foodNameL.text  = foodModel.title;
        foodNameL.numberOfLines = 0;
        [foodNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            if (tempL) {
                make.top.equalTo(tempL.mas_bottom).offset(5);
            } else {
                make.top.equalTo(self);
            }
            make.width.equalTo(self.mas_width).multipliedBy(0.4);// 设置宽度为自身的0.4倍
        }];
        
        tempL = foodNameL;
        
        // 餐品的价格
        UILabel *priceL = [UILabel new];
        [self addSubview:priceL];
        priceL.font = kFont14;
        priceL.textColor = [UIColor colorWithRed:0.84 green:0.14 blue:0.15 alpha:1.00];
        [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(foodNameL.mas_right).offset(5);
            make.top.equalTo(foodNameL);
        }];
        priceL.text = [NSString stringWithFormat:@"￥%@",foodModel.price];
        
        
        // 餐品数量
        UILabel *countL = [UILabel new];
        [self addSubview:countL];
        countL.font = kFont14;
        countL.textColor = priceL.textColor;
        [countL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceL);
            make.right.equalTo(self).offset(-5);
        }];
        countL.text = [NSString stringWithFormat:@"%@份",foodModel.quantity];
        
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
