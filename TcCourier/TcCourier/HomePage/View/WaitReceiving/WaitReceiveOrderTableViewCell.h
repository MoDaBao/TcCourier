//
//  WaitReceiveOrderTableViewCell.h
//  TcCourier
//
//  Created by 莫大宝 on 16/10/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@interface WaitReceiveOrderTableViewCell : UITableViewCell

- (void)setDataWithModel:(OrderInfoModel *)orderModel;

@end
