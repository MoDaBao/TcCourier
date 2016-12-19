//
//  ReceiverAddressInfoView.h
//  TcCourier
//
//  Created by 莫大宝 on 2016/12/14.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiverAddressInfoView : UIView

@property (nonatomic, assign) CGFloat selfheight;// 视图自身的高度
@property (nonatomic, strong) UILabel *disL;

- (instancetype)initWithReceiverName:(NSString *)receiverName tel:(NSString *)tel distance:(NSString *)distance address:(NSString *)address;


@end
