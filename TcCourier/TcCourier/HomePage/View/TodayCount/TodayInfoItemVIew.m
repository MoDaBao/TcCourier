//
//  TodayInfoItemVIew.m
//  peisongduan
//
//  Created by 莫大宝 on 16/6/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TodayInfoItemVIew.h"

@implementation TodayInfoItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title value:(NSString *)value {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor orangeColor];
        CGFloat centerY = frame.size.height * .5;
        UIFont *font = [UIFont systemFontOfSize:16];
        CGFloat height = [UILabel getHeightWithTitle:title font:font] + 6;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, centerY - height, frame.size.width, height)];
        titleLabel.numberOfLines = 2;
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = font;
//        titleLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:titleLabel];
        
        
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, centerY, frame.size.width, height)];
        valueLabel.font = font;
//        self.valueLabel.backgroundColor = [UIColor redColor];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        if ([title isEqualToString:@"今日有效单"]) {
            valueLabel.text = [NSString stringWithFormat:@"%@单",value];
        } else {
            valueLabel.text = [NSString stringWithFormat:@"￥%@元",value];
        }
        valueLabel.textColor = [UIColor colorWithRed:205 / 255.0 green:36 / 255.0 blue:29 / 255.0 alpha:1.0];
        [self addSubview:valueLabel];
        
    }
    return self;
}

@end
