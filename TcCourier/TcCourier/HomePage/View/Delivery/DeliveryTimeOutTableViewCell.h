//
//  DeliveryTimeOutTableViewCell.h
//  TcCourier
//
//  Created by M on 2016/12/14.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"
#import "ShopButtonView.h"

@interface DeliveryTimeOutTableViewCell : UITableViewCell

- (void)setDataWithModel:(OrderInfoModel *)orderModel;

@end
