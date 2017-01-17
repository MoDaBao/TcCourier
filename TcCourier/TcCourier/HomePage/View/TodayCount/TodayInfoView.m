//
//  TodayInfoView.m
//  peisongduan
//
//  Created by M on 16/6/22.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TodayInfoView.h"


@interface TodayInfoView ()

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation TodayInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSMutableArray *)dataArray {
    if (self = [super initWithFrame:frame]) {
        
        self.dataArray = dataArray;
        
        // 总行数
        NSInteger totalRow = 4;
        // 总列数
        NSInteger totalColumn = 2;
        // 水平方向上的间距
        CGFloat horizontalMargin = 20;
        // 垂直方向上的间距
        CGFloat verticalMargin = 15;
        // 宽
        CGFloat width = (self.width - horizontalMargin * 2) / totalColumn;
        // 高
        CGFloat height = self.height / totalRow;
        for (NSInteger i = 0; i < totalRow * totalColumn; i ++) {
            //计算行号
            NSInteger row = i / totalColumn;
            NSInteger col = i % totalColumn;
            TodayInfoItemView *view = [[TodayInfoItemView alloc] initWithFrame:CGRectMake(horizontalMargin + col * width, row * height, width, height) title:[self.dataArray[i] allKeys].firstObject value:[self.dataArray[i] allValues].firstObject];
//            NSLog(@"%ld",(long)i);
            view.tag = 4000 + i;
            [self addSubview:view];
        }
        
        // 中间竖线
        UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(self.width * .5, verticalMargin, 1, self.height - verticalMargin * 2)];
        middleLine.backgroundColor = kOrangeColor;
        [self addSubview:middleLine];
        
        // 横向上横线
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(horizontalMargin, height, self.width - horizontalMargin * 2, 1)];
        upLine.backgroundColor = kOrangeColor;
        [self addSubview:upLine];
        
        // 横向下横线
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(horizontalMargin, height * 2, self.width - horizontalMargin * 2, 1)];
        downLine.backgroundColor = kOrangeColor;
        [self addSubview:downLine];
        
        // 横向下下横线
        UIView *downLine2 = [[UIView alloc] initWithFrame:CGRectMake(horizontalMargin, height * 3, self.width - horizontalMargin * 2, 1)];
        downLine2.backgroundColor = kOrangeColor;
        [self addSubview:downLine2];
        
        // 顶部横线
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1)];
        topLine.backgroundColor = kOrangeColor;
        [self addSubview:topLine];
        
        // 底部横线
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
        bottomLine.backgroundColor = kOrangeColor;
        [self addSubview:bottomLine];
    }
    return self;
}






@end
