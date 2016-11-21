//
//  OrderDetailTableViewCell.h
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/21.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@interface OrderDetailTableViewCell : UITableViewCell


/**
 设置模型
 
 @param orderModel 订单模型
 @param index 当前cell的index值
 */
- (void)setDataWithModel:(OrderInfoModel *)orderModel index:(NSInteger)index;

@end
