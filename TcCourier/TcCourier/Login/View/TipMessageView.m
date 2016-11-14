//
//  TipMessageView.m
//  peisongduan
//
//  Created by 莫大宝 on 16/6/28.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TipMessageView.h"

@interface TipMessageView()


//@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TipMessageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithTip:(NSString *)tip {
    if (self = [super init]) {
        self.alpha = .0;
        self.layer.cornerRadius = 10;
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
        
        UILabel *tipLabel = [[UILabel alloc] init];
        [self addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.right.and.bottom.equalTo(self);
        }];
        tipLabel.text = tip;
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        [UIView animateWithDuration:.4 animations:^{
            self.alpha = .4;
        } completion:^(BOOL finished) {
            [self hide];
        }];
        
    }
    return self;
}

- (void)hide {
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = .0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
