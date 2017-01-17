//
//  OrderInfoModel.m
//  TcCourier
//
//  Created by M on 2016/11/15.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "OrderInfoModel.h"

@implementation OrderInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"payment_id"]) {
        if ([value isEqualToString:@"1"]) {
            self.payment = @"支付宝";
        } else if ([value isEqualToString:@"2"]) {
            self.payment = @"微信";
        } else {
            self.payment = @"货到付款";
        }
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.storeInfoArray = [NSMutableArray array];
        self.addressInfo = [[AddressInfoModel alloc] init];
    }
    return self;
}

@end
