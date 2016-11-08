//
//  AlredyDoneTableViewCell.m
//  TcCourier
//
//  Created by 莫大宝 on 16/11/4.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "AlredyDoneTableViewCell.h"

@implementation AlredyDoneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *numberL = [UILabel new];
        numberL.text = @"1";
        CGFloat margin = 10;
        numberL.font = [UIFont systemFontOfSize:15];
        [numberL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(@(margin));
            make.width.and.height.equalTo(@20);
        }];
        
        UIFont *font = [UIFont systemFontOfSize:14];
        UILabel *orderInfoL = [UILabel new];
        orderInfoL.font = font;
        [orderInfoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(numberL);
            make.left.equalTo(numberL.mas_right).offset(margin);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
