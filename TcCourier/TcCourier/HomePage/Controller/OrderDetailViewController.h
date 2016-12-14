//
//  OrderDetailViewController.h
//  TcCourier
//
//  Created by 莫大宝 on 16/11/4.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@interface OrderDetailViewController : UIViewController

@property (nonatomic, copy) NSString *orderNumber;
@property (nonatomic, copy) NSString *orderStatus;

@end
