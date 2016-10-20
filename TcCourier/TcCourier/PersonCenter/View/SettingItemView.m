//
//  SettingItemView.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/19.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "SettingItemView.h"

@implementation SettingItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray *)itemArray {
    if (self = [super initWithFrame:frame]) {
        CGFloat iconW = 20;
        CGFloat iconH = iconW;
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.height - iconH) * .5, iconW, iconH)];
        iconView.image = [UIImage imageNamed:itemArray[0]];
        [self addSubview:iconView];
        
        CGFloat margin = 10;
        UIFont *tipFont = [UIFont systemFontOfSize:14];
        CGFloat tipHeight = [UILabel getHeightWithTitle:itemArray[1] font:tipFont];
        CGFloat tipWidth = [UILabel getWidthWithTitle:itemArray[1] font:tipFont];
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.x + iconView.width + margin, (self.height - tipHeight) * .5, tipWidth, tipHeight)];
        tipLabel.text = itemArray[1];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = tipFont;
        [self addSubview:tipLabel];
        
        CGFloat rightW = 10;
        CGFloat rightH = rightW / 17 * 29;
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - rightW, (self.height - rightH) * .5, rightW, rightH)];
        rightView.image = [UIImage imageNamed:@"youbianjian"];
        [self addSubview:rightView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, self.width, self.height);
        [self addSubview:btn];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)click {
    _clickBlock();
}


@end
