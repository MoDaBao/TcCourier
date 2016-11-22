//
//  WaitReceiveOrderTableViewCell.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "WaitReceiveOrderTableViewCell.h"

@interface WaitReceiveOrderTableViewCell ()

@property (nonatomic, strong) UIView *contentV;// 内容视图
@property (nonatomic, strong) UILabel *orderNumberL;// 订单编号
@property (nonatomic, strong) UILabel *orderTimerL;// 订单时间
@property (nonatomic, strong) UILabel *orderTotalL;// 订单总额
@property (nonatomic, strong) UILabel *paymentL;// 支付方式
@property (nonatomic, strong) UILabel *receiveAddressL;// 收货地址
@property (nonatomic, strong) UILabel *courierCost;// 跑腿费
@property (nonatomic, strong) UILabel *commissionL;// 跑腿提成
@property (nonatomic, strong) ShopView *shopView;


@end


@implementation WaitReceiveOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat margin = 10;
        self.contentV = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, kScreenWidth - margin * 2, 100)];
        self.contentV.layer.borderWidth = 1;
        self.contentV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.contentV.layer.cornerRadius = 5;
        [self.contentView addSubview:_contentV];
        
        
        _orderNumberL = [UILabel new];
        [_contentV addSubview:_orderNumberL];
        
        _orderTimerL = [UILabel new];
        [_contentV addSubview:_orderTimerL];
        
        _orderTotalL = [UILabel new];
        [_contentV addSubview:_orderTotalL];
        
        _paymentL = [UILabel new];
        [_contentV addSubview:_paymentL];
        
        _receiveAddressL = [UILabel new];
        [_contentV addSubview:_receiveAddressL];
        
        _courierCost = [UILabel new];
        [_contentV addSubview:_courierCost];
        
        _commissionL = [UILabel new];
        [_contentV addSubview:_commissionL];
        
        OvertimePaidView *test = [[OvertimePaidView alloc] initWithFrame:CGRectMake(0, 0, _contentV.width, 40)];
        [_contentV addSubview:test];
        
        
        
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
