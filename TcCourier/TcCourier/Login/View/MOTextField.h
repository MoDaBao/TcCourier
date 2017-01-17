//
//  MOTextField.h
//  peisongduan
//
//  Created by M on 16/6/15.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOTextField : UIView

@property (nonatomic, strong) UITextField *tf;


- (instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor placeholder:(NSString *)placeholder lineColor:(UIColor *)lineColor tintColor:(UIColor *)tintColor font:(UIFont *)font icon:(UIImage *)icon secureTextEntry:(BOOL)secureTextEntry keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType;

- (void)changeBorderWidth:(CGFloat)width borderColor:(UIColor *)borderColor;

@end
