//
//  WaitReceiveOrderTableViewCell.h
//  TcCourier
//
//  Created by 莫大宝 on 16/10/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@protocol WaitReceiveOrderTableViewCellDelegate <NSObject>

- (void)waitReceiverCellShowTipMessageWithTip:(NSString *)tip;

@end

@interface WaitReceiveOrderTableViewCell : UITableViewCell

@property (nonatomic, assign) id<WaitReceiveOrderTableViewCellDelegate> delegate;

- (void)setDataWithModel:(OrderInfoModel *)orderModel;

@end
