//
//  ChooseView.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/27.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ChooseView.h"

@implementation ChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        NSArray *array = @[@"今天", @"一周内", @"一个月内", @"全部"];
        CGFloat height = 60;
        UIButton *lastBtn = nil;
        
        for (NSInteger i = 0; i < array.count; i ++) {
            
            UIButton *btn = [UIButton new];
            btn.tag = 1000 + i;
            [self addSubview:btn];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateSelected];
//            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(self);
                make.height.equalTo(@(height));
                if (lastBtn) {
                    make.top.equalTo(lastBtn.mas_bottom);
                } else {
                    make.top.equalTo(self.mas_top);
                    btn.selected = YES;
                }
            }];
            lastBtn = btn;
            
            
            UIImageView *line = [UIImageView new];
            [btn addSubview:line];
            line.image = [UIImage imageNamed:@"xuxian"];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.and.bottom.equalTo(btn);
                make.height.equalTo(@1);
            }];
            
        
        }
    }
    return self;
}

//- (void)click:(UIButton *)btn {
////    btn.selected = YES;
//    
//}




@end
