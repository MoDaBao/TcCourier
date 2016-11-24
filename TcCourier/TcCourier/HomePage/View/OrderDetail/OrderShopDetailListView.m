//
//  OrderShopDetailView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/22.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "OrderShopDetailListView.h"
#import "FoodListView.h"
#define kShopNameLWidth 120

@interface OrderShopDetailListView ()

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat margin;

@end

@implementation OrderShopDetailListView

- (void)loadOrderShopDetailListViewWithSotreInfoArray:(NSArray *)storeInfoArray {
    UILabel *tempL = nil;
    _margin = 5;
    _height = 0;
    
    for (StoreInfoModel *storeInfoModel in storeInfoArray) {
        
        // icon
        UIImageView *icon = [UIImageView new];
        icon.image = [UIImage imageNamed:@"dianpuxinxi"];
        [self addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@15);
            if (tempL) {
                make.top.equalTo(tempL.mas_bottom).offset(_margin);
            } else {
                make.top.equalTo(self).offset(_margin);
            }
            make.left.equalTo(self).offset(_margin);
        }];
        
        // shopname
        UILabel *shopNameL = [UILabel new];
        shopNameL.font = kFont14;
        [self addSubview:shopNameL];
        shopNameL.text = storeInfoModel.store_name;
        [shopNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(5);
            make.width.equalTo(@kShopNameLWidth);
        }];
        
        // foodlist
        FoodListView *foodListView = [FoodListView new];
        [self addSubview:foodListView];
        [foodListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopNameL.mas_right).offset(5);
            make.top.equalTo(shopNameL);
            make.right.equalTo(self);
            // 需要计算高度
            make.height.equalTo(@([self getFoodListViewHeightWithFoodArray:storeInfoModel.foodArray]));
        }];
        [foodListView loadDataWithFoodArray:storeInfoModel.foodArray];
        _height += [self getFoodListViewHeightWithFoodArray:storeInfoModel.foodArray];
        
        // 分割线
        float sortaPixel = 1.0 / [UIScreen mainScreen].scale;
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = [UIColor blackColor];
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon);
            make.top.equalTo(foodListView.mas_bottom).offset(_margin);
            make.height.equalTo(@(sortaPixel));
            make.right.equalTo(self).offset(-_margin);
        }];
        
        // 备注
        UILabel *remarkL = [UILabel new];
        [self addSubview:remarkL];
        remarkL.font = kFont14;
        remarkL.numberOfLines = 0;
        [remarkL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(line1);
            make.top.equalTo(line1.mas_bottom).offset(_margin);
        }];
        remarkL.text = [NSString stringWithFormat:@"备注:%@",storeInfoModel.remark];
        _height += [UILabel getHeightByWidth:kScreenWidth - 20 - _margin * 2 title:storeInfoModel.remark font:kFont14];
        
        // 分割线
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = [UIColor blackColor];
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.top.equalTo(remarkL.mas_bottom).offset(_margin);
            make.height.equalTo(@(sortaPixel));
        }];
        
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_height));
    }];
}




- (CGFloat)getFoodListViewHeightWithFoodArray:(NSArray *)foodArray {
    CGFloat height = 0;
    for (FoodModel *food in foodArray) {
        height += [UILabel getHeightByWidth:kScreenWidth - 20 - _margin * 2 - 15 - kShopNameLWidth title:food.title font:kFont14] + _margin;
        
    }
    return height - _margin;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





@end
