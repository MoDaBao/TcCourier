//
//  PersonCenterView.h
//  TcCourier
//
//  Created by 莫大宝 on 2016/12/12.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ModifyPasswordBlock)(void);
typedef void(^ContactBlock)(void);

@interface PersonCenterView : UIView

@property (nonatomic, copy) ModifyPasswordBlock modifyBlock;
@property (nonatomic, copy) ContactBlock contactBlock;
@property (nonatomic, strong) UILabel *effectiveOrderL;// 有效单数
@property (nonatomic, strong) UILabel *timeoutCountL;// 超时赔付单数
@property (nonatomic, strong) UILabel *timeoutPercentageL;// 超时赔付百分比

- (instancetype)initWithOrderCount:(NSString *)orderCount ordertimeout:(NSString *)ordertimeout timeout:(NSString *)timeout;

@end
