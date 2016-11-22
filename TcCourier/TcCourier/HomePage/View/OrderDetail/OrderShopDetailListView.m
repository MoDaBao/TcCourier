//
//  OrderShopDetailView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/22.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "OrderShopDetailListView.h"
#import "FoodListView.h"

@implementation OrderShopDetailListView


- (instancetype)initWithSotreInfoArray:(NSArray *)storeInfoArray {
    if (self = [super init]) {
        
        UILabel *tempL = nil;
        CGFloat margin = 5;
        
        for (StoreInfoModel *storeInfoModel in storeInfoArray) {
            
            // icon
            UIImageView *icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"dianpuxinxi"];
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.and.height.equalTo(@15);
                if (tempL) {
                    make.top.equalTo(tempL.mas_bottom).offset(margin);
                } else {
                    make.top.equalTo(self).offset(margin);
                }
                make.left.equalTo(self).offset(margin);
            }];
            
            
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
