//
//  OrderInfoModel.h
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/15.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreInfoModel.h"
#import "AddressInfoModel.h"

@interface OrderInfoModel : NSObject

@property (nonatomic, copy) NSString *order_number;
@property (nonatomic, copy) NSString *store_price;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *order_price;
@property (nonatomic, copy) NSString *payment;
@property (nonatomic, copy) NSString *order_run_fee;
@property (nonatomic, copy) NSString *service_time;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *ti_run_fee;
@property (nonatomic, strong) NSMutableArray *storeInfoArray;
@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *is_timeout;
@property (nonatomic, strong) AddressInfoModel *addressInfo;




@end
