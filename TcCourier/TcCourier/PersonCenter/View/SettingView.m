//
//  SettingView.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/19.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "SettingView.h"


@implementation SettingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat topMargin = 20;
        CGFloat margin = 40;
        float sortaPixel = 1.0 / [UIScreen mainScreen].scale;
        
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(topMargin, 0, self.width - topMargin * 2 , sortaPixel)];
        topLine.backgroundColor = [UIColor blackColor];
        [self addSubview:topLine];
        
        _passwordItem = [[SettingItemView alloc] initWithFrame:CGRectMake(margin, 0, self.width - margin * 2, self.height * .5) itemArray:@[@"xiugaimima", @"修改密码"]];
        [self addSubview:_passwordItem];
        
        UIView *betweenLine = [[UIView alloc] initWithFrame:CGRectMake(margin, _passwordItem.y + _passwordItem.height, self.width - margin * 2, sortaPixel)];
        betweenLine.backgroundColor = [UIColor blackColor];
        [self addSubview:betweenLine];
        
        _contactItem = [[SettingItemView alloc] initWithFrame:CGRectMake(margin, _passwordItem.y + _passwordItem.height, self.width - margin * 2, self.height * .5) itemArray:@[@"lianxikefu", @"联系客服"]];
        [self addSubview:_contactItem];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(topMargin, self.height - 1, self.width - topMargin * 2, sortaPixel)];
        bottomLine.backgroundColor = [UIColor blackColor];
        [self addSubview:bottomLine];
        
    }
    return self;
}

@end
