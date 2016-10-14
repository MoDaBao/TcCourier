//
//  MOTextField.m
//  peisongduan
//
//  Created by 莫大宝 on 16/6/15.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "MOTextField.h"


@implementation MOTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder lineColor:(UIColor *)lineColor tintColor:(UIColor *)tintColor font:(UIFont *)font icon:(UIImage *)icon {
    if (self = [super initWithFrame:frame]) {
        
        // textfield与view的间距
        CGFloat margin = 10;
        
        if (!icon) {
            self.textField = [[UITextField alloc] initWithFrame:CGRectMake(margin, 0, self.width - margin * 2, self.height)];
        } else {
            UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 5, 15, 18)];
            iconV.image = icon;
            [self addSubview:iconV];
            self.textField = [[UITextField alloc] initWithFrame:CGRectMake(iconV.x + iconV.width + margin, 0, self.width - margin * 3 - iconV.width, self.height)];
            [self addSubview:self.textField];
        }
        
        self.textField.placeholder = placeholder;
        self.textField.tintColor = tintColor;// 修改光标颜色
        self.textField.font = font;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.textField];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height -  1, self.width, 1)];
        line.backgroundColor = lineColor;
        [self addSubview:line];
    }
    return self;
    
    
}



@end
