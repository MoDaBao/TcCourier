//
//  HeartAppraiseRateView.h
//  peisongduan
//
//  Created by M on 16/6/21.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarttAppraiseRateView : UIView

- (instancetype)initWithFrame:(CGRect)frame goodRate:(CGFloat)goodRate;
- (void)updateGoodRateWith:(CGFloat)goodRate;
@end
