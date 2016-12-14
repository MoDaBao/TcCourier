//
//  StoreInfoModel.h
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/16.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreInfoModel : NSObject

@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *Purchasing;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *longitudeG;
@property (nonatomic, copy) NSString *latitudeG;
@property (nonatomic, copy) NSString *is_timeout;
@property (nonatomic, copy) NSString *total_price;
@property (nonatomic, copy) NSString *coupon;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *order_id;

@property (nonatomic, strong) NSMutableArray *foodArray;


@end
