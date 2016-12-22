//
//  TodayCountDetailTableViewCell.h
//  TcCourier
//
//  Created by 莫大宝 on 2016/12/22.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayCountModel.h"

@interface TodayCountDetailTableViewCell : UITableViewCell

- (void)setDataWithModel:(TodayCountModel *)model title:(NSString *)title;

@end
