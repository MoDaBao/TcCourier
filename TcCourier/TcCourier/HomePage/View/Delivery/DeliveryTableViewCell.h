//
//  DeliveryTableViewCell.h
//  TcCourier
//
//  Created by M on 2016/11/29.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"
#import "ShopButtonView.h"

@interface DeliveryTableViewCell : UITableViewCell

- (void)setDataWithModel:(OrderInfoModel *)orderModel;

@end
