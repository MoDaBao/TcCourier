//
//  overtimePaidView.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/25.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "OvertimePaidView.h"

@implementation OvertimePaidView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        
        CGFloat margin = 10;
        NSString *title = @"超时赔付：";
        
        UILabel *titleL = [UILabel new];
        [self addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@(margin));
        }];
        titleL.text = title;
        titleL.font = [UIFont systemFontOfSize:14];
        
        UILabel *timeL = [UILabel new];
        [self addSubview:timeL];
        [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@-20);
        }];
        timeL.font = [UIFont systemFontOfSize:14];
        timeL.text = @"剩余时间：";
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat margin = 10;
        NSString *title = @"超时赔付：";
        
        UILabel *titleL = [UILabel new];
        [self addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@(margin));
        }];
        titleL.text = title;
        titleL.font = [UIFont systemFontOfSize:14];
        
        UILabel *timeL = [UILabel new];
        [self addSubview:timeL];
        [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@-20);
        }];
        timeL.font = [UIFont systemFontOfSize:14];
        timeL.text = @"剩余时间：";
        
    }
    return self;
}


@end
