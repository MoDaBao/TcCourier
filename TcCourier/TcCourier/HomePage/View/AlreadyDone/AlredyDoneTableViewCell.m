//
//  AlredyDoneTableViewCell.m
//  TcCourier
//
//  Created by 莫大宝 on 16/11/4.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "AlredyDoneTableViewCell.h"
#import "AddressListView.h"

@interface AlredyDoneTableViewCell ()

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat numberLWidth;

@property (nonatomic, strong) UILabel *numberL;// 编号标签
@property (nonatomic, strong) UILabel *orderInfoL;// 支付方式——距离——订单状态
@property (nonatomic, strong) UILabel *orderNumberL;// 订单编号
@property (nonatomic, strong) UILabel *orderTimeL;// 下单时间
@property (nonatomic, strong) AddressListView *storeAddressListV;// 商家地址列表
@property (nonatomic, strong) AddressListView *receiverAddressListV;// 收货地址列表
;
@property (nonatomic, strong) UIView *contentV;


@end

@implementation AlredyDoneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _margin = 5;
        
        // 内容视图
        self.contentV = [[UIView alloc] init];
        self.contentV.layer.borderWidth = 1;
        self.contentV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.contentV.layer.cornerRadius = 5;
        [self.contentView addSubview:_contentV];
        [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(_margin, _margin, _margin, _margin));
        }];
        
        // 编号
        _numberL = [UILabel new];
        [self.contentV addSubview:self.numberL];
        _numberLWidth = 18;
        self.numberL.font = [UIFont systemFontOfSize:15];
        [self.numberL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(@(_margin));
            make.width.and.height.equalTo(@(_numberLWidth));
        }];
        self.numberL.clipsToBounds = YES;
        self.numberL.layer.cornerRadius = _numberLWidth * .5;
        self.numberL.backgroundColor = [UIColor colorWithRed:0.92 green:0.33 blue:0.30 alpha:1.00];
        self.numberL.textColor = [UIColor whiteColor];
        self.numberL.textAlignment = NSTextAlignmentCenter;
        self.numberL.font = [UIFont systemFontOfSize:13];
        
        // 支付方式——距离——订单状态
        _orderInfoL = [UILabel new];
        [self.contentV addSubview:_orderInfoL];
        _orderInfoL.font = kFont14;
        _orderInfoL.numberOfLines = 0;
        [_orderInfoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.numberL);
            make.left.equalTo(self.numberL.mas_right).offset(_margin);
            make.right.equalTo(self.contentV);
        }];
        
        // 店家地址标签
        UILabel *dianjiadizhi = [UILabel new];
        dianjiadizhi.text = @"店家地址:";
        [self.contentV addSubview:dianjiadizhi];
        dianjiadizhi.font = kFont14;
        [dianjiadizhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_orderInfoL);
            make.top.equalTo(_orderInfoL.mas_bottom).offset(_margin);
            make.width.equalTo(@([UILabel getWidthWithTitle:dianjiadizhi.text font:kFont14]));
        }];
        
        // 店家地址列表
        _storeAddressListV = [AddressListView new];
        [self.contentV addSubview:_storeAddressListV];
        [_storeAddressListV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(dianjiadizhi.mas_right).offset(_margin);
            make.top.equalTo(dianjiadizhi);
            make.height.equalTo(@10);// 临时的约束
            make.right.equalTo(self.contentV.mas_right);
        }];
        
        // 收货地址标签
        UILabel *shouhuodizhi = [UILabel new];
        shouhuodizhi.text = @"收货地址:";
        [self.contentV addSubview:shouhuodizhi];
        shouhuodizhi.font = kFont14;
        [shouhuodizhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(dianjiadizhi);
            make.top.equalTo(_storeAddressListV.mas_bottom).offset(_margin);
            make.width.equalTo(@([UILabel getWidthWithTitle:shouhuodizhi.text font:kFont14]));
        }];
        
        // 收货地址列表标签
        _receiverAddressListV = [AddressListView new];
        [self.contentV addSubview:_receiverAddressListV];
        [_receiverAddressListV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_storeAddressListV);
            make.top.equalTo(shouhuodizhi);
            make.right.equalTo(self.contentV);
            make.height.equalTo(@10);
        }];
        
        
        // 分割线
        float sortaPixel = 1.0 / [UIScreen mainScreen].scale;
        UIView *line = [[UIView alloc] init];
        line.backgroundColor=[UIColor blackColor];
        [self.contentV addSubview:line];//线是否加
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentV);
            make.top.equalTo(_receiverAddressListV.mas_bottom).offset(_margin);
            make.height.equalTo(@(sortaPixel));
        }];
        
        // 订单编号
        _orderNumberL = [UILabel new];
        [self.contentV addSubview:_orderNumberL];
        _orderNumberL.font = kFont14;
        [_orderNumberL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shouhuodizhi);
            make.top.equalTo(line.mas_bottom).offset(_margin);
        }];
        
        // 下单时间
        _orderTimeL = [UILabel new];
        [self.contentV addSubview:_orderTimeL];
        _orderTimeL.font = kFont14;
        [_orderTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shouhuodizhi);
            make.top.equalTo(_orderNumberL.mas_bottom).offset(_margin);
        }];
        
        
    }
    return self;
}

- (void)setDataWithModel:(OrderInfoModel *)orderModel index:(NSInteger)index tableWidth:(CGFloat)tableWidth {
    
    // 计算地址列表视图的宽度
    CGFloat listViewWidth = tableWidth - _margin * 2 - (_margin * 3 + _numberLWidth + [UILabel getWidthWithTitle:@"店家地址:" font:_orderInfoL.font]);
    
    _numberL.text = [NSString stringWithFormat:@"%ld",(long)index + 1];// 加载编号
    
    // 加载 支付方式——距离——订单状态
    if ([orderModel.is_timeout isEqualToString:@"1"]) {// 有超时赔付
         _orderInfoL.text = [NSString stringWithFormat:@"%@ - 距%@km - 超时赔付 - %@",orderModel.payment, orderModel.distance, @"已完成"];
    } else {// 无超时赔付
        _orderInfoL.text = [NSString stringWithFormat:@"%@ - 距%@km - %@",orderModel.payment, orderModel.distance, @"已完成"];
    }
    
    [_storeAddressListV loadLabelWithArray:orderModel.storeInfoArray font:_orderInfoL.font width:listViewWidth];// 加载店铺地址
    [_receiverAddressListV loadLabelWithAddressInfoModel:orderModel.addressInfo font:_orderInfoL.font width:listViewWidth];// 加载收货地址
    _orderNumberL.text = [NSString stringWithFormat:@"订单编号:%@",orderModel.order_number];// 加载订单编号
    _orderTimeL.text = [NSString stringWithFormat:@"下单时间:%@",orderModel.ctime];// 加载下单时间
    
    
    
    
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
