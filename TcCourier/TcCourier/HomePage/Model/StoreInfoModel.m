//
//  StoreInfoModel.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/16.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "StoreInfoModel.h"

@implementation StoreInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"status"]) {
        if ([value isEqualToString:@"5"]) {
            self.orderStatus = @"已送达";
        } else if ([value isEqualToString:@"1"]) {
            self.orderStatus = @"已完成";
        } else if ([value isEqualToString:@"2"]) {
            self.orderStatus = @"已关闭";
        } else if ([value isEqualToString:@"3"]) {
            self.orderStatus = @"待付款";
        } else if ([value isEqualToString:@"6"]) {
            self.orderStatus = @"已关闭";
        } else if ([value isEqualToString:@"10"]) {
            self.orderStatus = @"已完成";
        } else if ([value isEqualToString:@"13"]) {
            self.orderStatus = @"待跑腿接单";
        } else if ([value isEqualToString:@"14"]) {
            self.orderStatus = @"等待店铺接单";
        } else if ([value isEqualToString:@"4"]) {
            self.orderStatus = @"等待跑腿取餐";
        } else if ([value isEqualToString:@"12"]) {
            self.orderStatus = @"跑腿正在配送";
        }
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.foodArray = [NSMutableArray array];
    }
    return self;
}

@end
