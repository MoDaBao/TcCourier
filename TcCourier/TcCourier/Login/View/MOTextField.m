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

- (instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor placeholder:(NSString *)placeholder lineColor:(UIColor *)lineColor tintColor:(UIColor *)tintColor font:(UIFont *)font icon:(UIImage *)icon secureTextEntry:(BOOL)secureTextEntry keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = bgColor;
        
        // textfield与view的间距
        CGFloat margin = 10;
        
        if (!icon) {
            self.tf = [[UITextField alloc] initWithFrame:CGRectMake(margin, 0, self.width - margin * 2, self.height)];
        } else {
            UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 5, 12, 16)];
            iconV.image = icon;
            [self addSubview:iconV];
            self.tf = [[UITextField alloc] initWithFrame:CGRectMake(iconV.x + iconV.width + margin, 0, self.width - margin * 3 - iconV.width, self.height)];
            [self addSubview:self.tf];
        }
        
        self.tf.placeholder = placeholder;
        self.tf.tintColor = tintColor;// 修改光标颜色
        self.tf.font = font;
        self.tf.secureTextEntry = secureTextEntry;
        self.tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.tf.keyboardType = keyboardType;
        self.tf.returnKeyType = returnKeyType;
        [self addSubview:self.tf];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height -  1, self.width, 1)];
        line.backgroundColor = lineColor;
        [self addSubview:line];
    }
    return self;
    
    
}

- (void)changeBorderWidth:(CGFloat)width borderColor:(UIColor *)borderColor {
    self.layer.borderWidth = width;
    self.layer.borderColor = borderColor.CGColor;
}



@end
