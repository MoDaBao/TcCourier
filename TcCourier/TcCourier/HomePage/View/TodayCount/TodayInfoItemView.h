//
//  TodayInfoItemVIew.h
//  peisongduan
//
//  Created by 莫大宝 on 16/6/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BTNClickBlock)(void);


@interface TodayInfoItemView : UIView

//@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, copy) BTNClickBlock btnClickBlock;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title value:(NSString *)value;


@end
