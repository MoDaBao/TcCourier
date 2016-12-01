//
//  DeliveryTableViewCell.h
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/29.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@interface DeliveryTableViewCell : UITableViewCell

- (void)setDataWithModel:(OrderInfoModel *)orderModel;

@end
