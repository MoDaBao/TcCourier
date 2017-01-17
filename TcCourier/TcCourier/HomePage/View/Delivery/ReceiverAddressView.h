//
//  ReceiverAddressView.h
//  TcCourier
//
//  Created by M on 2016/11/29.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfoModel.h"

@interface ReceiverAddressView : UIView

- (void)loadReceiverAddress:(AddressInfoModel *)addressInfoModel orderNumber:(NSString *)orderNumber;

@end
