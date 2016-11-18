//
//  AlredyDoneTableViewCell.h
//  TcCourier
//
//  Created by 莫大宝 on 16/11/4.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@interface AlredyDoneTableViewCell : UITableViewCell


/**
 设置模型

 @param orderModel 订单模型
 @param index 当前cell的index值
 @param tableWidth cell所在的tableView的宽度
 */
- (void)setDataWithModel:(OrderInfoModel *)orderModel index:(NSInteger)index tableWidth:(CGFloat)tableWidth;


@end
