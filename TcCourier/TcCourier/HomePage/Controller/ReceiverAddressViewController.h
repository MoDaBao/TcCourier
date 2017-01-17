//
//  ReceiverAddressViewController.h
//  TcCourier
//
//  Created by M on 2016/12/2.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfoModel.h"

@interface ReceiverAddressViewController : UIViewController

//@property (nonatomic, copy) NSString *orderNumber;
@property (nonatomic, strong) AddressInfoModel *addressInfoModel;

@end
