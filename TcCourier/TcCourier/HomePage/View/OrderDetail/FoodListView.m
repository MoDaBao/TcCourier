//
//  FoodListView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/22.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "FoodListView.h"

@implementation FoodListView

- (instancetype)initWithFoodArray:(NSArray *)foodArray {
    if (self = [super init]) {
        // 临时变量
        UILabel *tempL = nil;
        for (FoodModel *foodModel in foodArray) {
            // 餐品名称
            UILabel *foodNameL = [UILabel new];
            [self addSubview:foodNameL];
            foodNameL.font = kFont14;
            foodNameL.text  = foodModel.title;
            [foodNameL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                if (tempL) {
                    make.top.equalTo(tempL.mas_bottom).offset(5);
                } else {
                    make.top.equalTo(self);
                }
            }];
            
            tempL = foodNameL;
            
            // 餐品的价格和数量
            UILabel *priceAndCountL = [UILabel new];
            [self addSubview:priceAndCountL];
            priceAndCountL.font = kFont14;
            priceAndCountL.textColor = [UIColor colorWithRed:0.84 green:0.14 blue:0.15 alpha:1.00];
            [priceAndCountL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self);
                make.top.equalTo(foodNameL);
            }];
            priceAndCountL.text = [NSString stringWithFormat:@"￥%@  %@份",foodModel.price, foodModel.quantity];
        }
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
