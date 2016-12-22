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

- (instancetype)initWithOrderCount:(NSString *)orderCount ordertimeout:(NSString *)ordertimeout timeout:(NSString *)timeout;

@end
