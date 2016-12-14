//
//  PersonCenterView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/12/12.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "PersonCenterView.h"

@interface PersonCenterView ()

@property (nonatomic, strong) UILabel *effectiveOrderL;// 有效单数
@property (nonatomic, strong) UILabel *timeoutCountL;// 超时赔付单数
@property (nonatomic, strong) UILabel *timeoutPercentageL;// 超时赔付百分比


@end

@implementation PersonCenterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat margin = 15;
        CGFloat sortaPixel = 1.0 / [UIScreen mainScreen].scale;
        
        // 顶部横线
        UIView *topline = [UIView new];
        [self addSubview:topline];
        [topline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.right.and.left.equalTo(self);
            make.height.equalTo(@(sortaPixel));
        }];
        topline.backgroundColor = [UIColor lightGrayColor];
        
        // 有效总单数-title
        UILabel *effectiveOrder = [UILabel new];
        [self addSubview:effectiveOrder];
        [effectiveOrder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topline.mas_bottom).offset(margin);
            make.centerX.equalTo(self);
        }];
        effectiveOrder.font = kFont14;
        effectiveOrder.text = @"有效总单数";
        
        // 有效总单数-值
        _effectiveOrderL = [UILabel new];
        [self addSubview:_effectiveOrderL];
        [_effectiveOrderL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(effectiveOrder.mas_bottom).offset(margin);
            make.centerX.equalTo(self);
        }];
        _effectiveOrderL.font = kFont14;
        _effectiveOrderL.text = @"123";
        
        
        // 分割线1
        UIView *line1 = [UIView new];
        [self addSubview:line1];
        line1.backgroundColor = [UIColor lightGrayColor];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.height.equalTo(@(sortaPixel));
            make.top.equalTo(_effectiveOrderL.mas_bottom).offset(margin);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        // 竖向分割线
        UIView *shuline = [UIView new];
        [self addSubview:shuline];
        shuline.backgroundColor = [UIColor lightGrayColor];
        [shuline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(@(sortaPixel));
            make.top.equalTo(line1.mas_bottom);
            make.bottom.equalTo(self);
        }];
        
        // 超时赔付单数-title
        UILabel *timeoutCount = [UILabel new];
        [self addSubview:timeoutCount];
        [timeoutCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1.mas_bottom).offset(margin);
            make.centerX.equalTo(self.mas_centerX).multipliedBy(.5);
        }];
        timeoutCount.font = kFont14;
        timeoutCount.text = @"超时赔付总单数";
        
        // 超时赔付单数-值
        _timeoutCountL = [UILabel new];
        [self addSubview:_timeoutCountL];
        [_timeoutCountL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeoutCount.mas_bottom).offset(margin);
            make.centerX.equalTo(timeoutCount);
        }];
        _timeoutCountL.font = kFont14;
        _timeoutCountL.text = @"123";
        
        // 超时赔付百分比-title
        UILabel *timeoutPercentage = [UILabel new];
        [self addSubview:timeoutPercentage];
        [timeoutPercentage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeoutCount);
            make.centerX.equalTo(self.mas_centerX).multipliedBy(1.5);
        }];
        timeoutPercentage.font = kFont14;
        timeoutPercentage.text = @"超时赔付百分比";
        
        // 超时赔付百分比-值
        _timeoutPercentageL = [UILabel new];
        [self addSubview:_timeoutPercentageL];
        [_timeoutPercentageL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(timeoutPercentage);
            make.top.equalTo(_timeoutCountL);
        }];
        _timeoutPercentageL.font = kFont14;
        _timeoutPercentageL.text = @"2333";
        
        
        // 分割线
        UIView *line2 = [UIView new];
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_timeoutCountL.mas_bottom).offset(margin);
            make.width.and.centerX.equalTo(self);
            make.height.equalTo(@(sortaPixel));
        }];
        line2.backgroundColor = line1.backgroundColor;
        
        // 底部横线
        UIView *bottomLine = [UIView new];
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(self);
            make.height.equalTo(@(sortaPixel));
        }];
        bottomLine.backgroundColor = line2.backgroundColor;
        
        // 修改密码
        UIButton *modifierPassword = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:modifierPassword];
        [modifierPassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line2.mas_bottom);
            make.right.equalTo(shuline.mas_left);
            make.left.equalTo(self);
            make.height.equalTo(@78);
        }];
        [modifierPassword setTitle:@"修改密码" forState:UIControlStateNormal];
        [modifierPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [modifierPassword addTarget:self action:@selector(modifierPassword:) forControlEvents:UIControlEventTouchUpInside];
        modifierPassword.titleLabel.font = kFont14;
        
        // 联系客服
        UIButton *contactService = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:contactService];
        [contactService mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(modifierPassword);
            make.left.equalTo(shuline.mas_right);
            make.right.equalTo(self);
            make.height.equalTo(modifierPassword.mas_height);
        }];
        [contactService setTitle:@"联系客服" forState:UIControlStateNormal];
        [contactService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [contactService addTarget:self action:@selector(contactService:) forControlEvents:UIControlEventTouchUpInside];
        contactService.titleLabel.font = kFont14;
    }
    return self;
}

// 修改密码
- (void)modifierPassword:(UIButton *)btn {
    if (self.modifyBlock) {
        self.modifyBlock();
    }
}

// 联系客服
- (void)contactService:(UIButton *)btn {
    if (self.contactBlock) {
        self.contactBlock();
    }
}


@end
