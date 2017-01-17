//
//  AddressInfoModel.h
//  TcCourier
//
//  Created by M on 2016/11/16.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfoModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *longitudeG;
@property (nonatomic, copy) NSString *latitudeG;
@property (nonatomic, copy) NSString *detail_addr;
@property (nonatomic, copy) NSString *lng;// 距离


@end
