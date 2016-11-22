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


/**
 设置价格富文本
 
 @param label 需要设置富文本的标签对象
 @param title 例如 订单总额:
 @param sum 例如 ￥10.00
 */
- (void)setAttStrWithlabel:(UILabel *)label title:(NSString *)title sum:(NSString *)sum;

@end
