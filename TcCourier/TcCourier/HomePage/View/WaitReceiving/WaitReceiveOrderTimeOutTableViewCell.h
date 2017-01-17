//
//  WaitReceiveOrderTimeOutTableViewCell.h
//  TcCourier
//
//  Created by M on 2016/12/29.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@protocol WaitReceiveOrderTimeOutTableViewCellDelegate <NSObject>

- (void)waitReceiverTimeOutCellShowTipMessageWithTip:(NSString *)tip;
- (void)refreshWaitReceiveTimeOut;

@end

@interface WaitReceiveOrderTimeOutTableViewCell : UITableViewCell

@property (nonatomic, assign) id<WaitReceiveOrderTimeOutTableViewCellDelegate> delegate;

- (void)setDataWithModel:(OrderInfoModel *)orderModel;

@end
