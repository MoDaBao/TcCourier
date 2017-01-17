//
//  StoreListView.h
//  TcCourier
//
//  Created by M on 2016/11/16.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfoModel.h"

@interface AddressListView : UIView


/**
 加载店铺地址列表

 @param array 店铺地址模型数组
 @param font <#font description#>
 @param width self的宽度
 */
- (void)loadLabelWithArray:(NSArray *)array font:(UIFont *)font width:(CGFloat)width;


/**
 加载收货地址列表

 @param addressModel 收货地址模型
 @param font <#font description#>
 @param width self的宽度
 */
- (void)loadLabelWithAddressInfoModel:(AddressInfoModel *)addressModel font:(UIFont *)font width:(CGFloat)width;

@end
