//
//  TodayCountDetailTableViewCell.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/12/22.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TodayCountDetailTableViewCell.h"

@interface TodayCountDetailTableViewCell ()

@property (nonatomic, strong) UILabel *orderNumberL;
@property (nonatomic, strong) UILabel *orderTimeL;
@property (nonatomic, strong) UILabel *priceL;

@end

@implementation TodayCountDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat margin = 10;
        
        _orderNumberL = [UILabel new];
        [self.contentView addSubview:_orderNumberL];
        [_orderNumberL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(@(margin));
        }];
        _orderNumberL.font = [UIFont systemFontOfSize:15];
        
        _orderTimeL = [UILabel new];
        [self.contentView addSubview:_orderTimeL];
        [_orderTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_orderNumberL);
            make.top.equalTo(_orderNumberL.mas_bottom).offset(margin);
        }];
        _orderTimeL.font = [UIFont systemFontOfSize:12];
        _orderTimeL.textColor = [UIColor lightGrayColor];
        
        _priceL = [UILabel new];
        [self.contentView addSubview:_priceL];
        [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-margin);
        }];
        _priceL.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}

- (void)setDataWithModel:(TodayCountModel *)model title:(NSString *)title {
    _orderNumberL.text = [NSString stringWithFormat:@"订单号:%@",model.orderno];
    _orderTimeL.text = [NSString stringWithFormat:@"下单时间:%@",model.ctime];
    if ([title isEqualToString:@"今日提成"]) {
        _priceL.text = [NSString stringWithFormat:@"%@  %@",@"提成", model.price];
    } else if ([title isEqualToString:@"跑腿费(在线支付)"] || [title isEqualToString:@"跑腿费(货到付款)"]) {
        _priceL.text = [NSString stringWithFormat:@"%@  %@",@"跑腿费", model.price];
    } else if ([title isEqualToString:@"餐品费(在线支付)"] || [title isEqualToString:@"餐品费(货到付款)"]) {
        _priceL.text = [NSString stringWithFormat:@"%@  %@",@"餐品费", model.price];
    } else if ([title isEqualToString:@"代购费(在线支付)"] || [title isEqualToString:@"代购费(货到付款)"]) {
        _priceL.text = [NSString stringWithFormat:@"%@  %@",@"代购费", model.price];

    }
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
