//
//  OrderInfoModel.h
//  TcCourier
//
//  Created by M on 2016/11/15.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreInfoModel.h"
#import "AddressInfoModel.h"
#import "FoodModel.h"

@interface OrderInfoModel : NSObject


@property (nonatomic, copy) NSString *order_number;
@property (nonatomic, copy) NSString *store_price;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *order_price;
@property (nonatomic, copy) NSString *payment;// 支付方式
@property (nonatomic, copy) NSString *order_run_fee;
@property (nonatomic, copy) NSString *service_time;// 期望送达时间
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *ti_run_fee;
@property (nonatomic, strong) NSMutableArray *storeInfoArray;
@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *is_timeout;// 是否有超时赔付
@property (nonatomic, strong) AddressInfoModel *addressInfo;

@property (nonatomic, copy) NSString *coupon;
@property (nonatomic, copy) NSString *food_price;
@property (nonatomic, copy) NSString *box_fee;
@property (nonatomic, copy) NSString *dai;// 代购餐品费
@property (nonatomic, copy) NSString *pda_finly;// 跑腿送达时间

@property (nonatomic, copy) NSString *timeout_status;// 是否超时 0没有超时||1超时
@property (nonatomic, copy) NSString *timeout;// 超时赔付剩余时间




@end
