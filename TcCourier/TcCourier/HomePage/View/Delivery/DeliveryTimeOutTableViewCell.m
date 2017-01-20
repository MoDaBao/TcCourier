//
//  DeliveryTimeOutTableViewCell.m
//  TcCourier
//
//  Created by M on 2016/12/14.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "DeliveryTimeOutTableViewCell.h"
#import "TotalAmountAndPaymentView.h"
#import "ReceiverAddressView.h"
#import "RunFeeAndTiFeeView.h"
#import "TimeOutView.h"

@interface DeliveryTimeOutTableViewCell ()

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, strong) UILabel *orderNumberL;// 订单编号
@property (nonatomic, strong) UILabel *orderTimeL;// 下单时间
@property (nonatomic, strong) TotalAmountAndPaymentView *totalAndPaymentView;// 订单总额和支付方式
@property (nonatomic, strong) ReceiverAddressView *receiverAddressView;// 收货人地址
@property (nonatomic, strong) RunFeeAndTiFeeView *runFeeAndTiFeeView;// 跑腿费和跑腿提成

@property (nonatomic, strong) TimeOutView *timeOutView;// 超时赔付

@property (nonatomic, strong) ShopButtonView *shopBtnView;// 店铺信息

@end

@implementation DeliveryTimeOutTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _margin = 5;
        
        // 内容视图
        self.contentV = [[UIView alloc] init];
        self.contentV.layer.borderWidth = 1;
        self.contentV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.contentV.layer.cornerRadius = 5;
        self.contentV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_contentV];
        [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
        
        // 订单编号
        _orderNumberL = [UILabel new];
        [self.contentV addSubview:_orderNumberL];
        _orderNumberL.font = kFont14;
        [_orderNumberL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(@(_margin));
        }];
        
        // 下单时间
        _orderTimeL = [UILabel new];
        [self.contentV addSubview:_orderTimeL];
        _orderTimeL.font = kFont14;
        [_orderTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_orderNumberL);
            make.top.equalTo(_orderNumberL.mas_bottom).offset(_margin);
        }];
        
        // 分割线
        float sortaPixel = 1.0 / [UIScreen mainScreen].scale;
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor blackColor];
        [self.contentV addSubview:line];//线是否加
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentV);
            make.top.equalTo(_orderTimeL.mas_bottom).offset(_margin);
            make.height.equalTo(@(sortaPixel));
        }];
        
        // 订单总额和支付方式
        _totalAndPaymentView = [TotalAmountAndPaymentView new];
        [self.contentV addSubview:_totalAndPaymentView];
        [_totalAndPaymentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentV);
            make.top.equalTo(line.mas_bottom);
            make.height.equalTo(@40);
        }];
        
        // 分割线
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = [UIColor blackColor];
        [self.contentV addSubview:line2];//线是否加
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentV);
            make.top.equalTo(_totalAndPaymentView.mas_bottom);
            make.height.equalTo(@(sortaPixel));
        }];
        
        // 收货人地址
        _receiverAddressView = [ReceiverAddressView new];
        [self.contentV addSubview:_receiverAddressView];
        [_receiverAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentV);
            make.top.equalTo(line2.mas_bottom);
            make.height.equalTo(@40);
        }];
        
        // 分割线
        UIView *line3 = [[UIView alloc] init];
        line3.backgroundColor = [UIColor blackColor];
        [self.contentV addSubview:line3];//线是否加
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentV);
            make.top.equalTo(_receiverAddressView.mas_bottom);
            make.height.equalTo(@(sortaPixel));
        }];
        
        // 跑腿费和跑腿提成
        _runFeeAndTiFeeView = [RunFeeAndTiFeeView new];
        [self.contentV addSubview:_runFeeAndTiFeeView];
        [_runFeeAndTiFeeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentV);
            make.top.equalTo(line3.mas_bottom);
            make.height.equalTo(@40);
        }];
        
        // 分割线
        UIView *line4 = [[UIView alloc] init];
        line4.backgroundColor = [UIColor blackColor];
        [self.contentV addSubview:line4];//线是否加
        [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentV);
            make.top.equalTo(_runFeeAndTiFeeView.mas_bottom);
            make.height.equalTo(@(sortaPixel));
        }];
        
        // 超时赔付
        _timeOutView = [TimeOutView new];
        [self.contentV addSubview:_timeOutView];
        [_timeOutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentV);
            make.top.equalTo(line4.mas_bottom);
            make.height.equalTo(@40);
        }];
        
        // 店铺信息
        _shopBtnView = [ShopButtonView new];
        [self.contentV addSubview:_shopBtnView];
        [_shopBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentV);
            make.top.equalTo(_timeOutView.mas_bottom);
//            make.height.equalTo(@40);// 高度在ShopButtonView的加载方法设置
        }];
        _shopBtnView.delegate = [UIViewController getCurrentViewController];
//        _shopBtnView.backgroundColor = [UIColor randomColor];
//        _timeOutView.backgroundColor = [UIColor randomColor];
        
        
        
    }
    return self;
}

- (void)setDataWithModel:(OrderInfoModel *)orderModel {
    _orderNumberL.text = [NSString stringWithFormat:@"订单编号:%@",orderModel.order_number];// 加载订单编号
    _orderTimeL.text = [NSString stringWithFormat:@"下单时间:%@",orderModel.ctime];// 加载下单时间
    // 加载订单总额和支付方式
    [_totalAndPaymentView loadTotalAmount:orderModel.order_price payment:orderModel.payment];
    // 加载收货人地址
    [_receiverAddressView loadReceiverAddress:orderModel.addressInfo orderNumber:orderModel.order_number];
    // 加载跑腿费和跑腿提成
    [_runFeeAndTiFeeView loadRunFee:orderModel.order_run_fee tiFee:orderModel.ti_run_fee];
    
    // 超时赔付
    [_timeOutView loadTimeOut:orderModel.timeout];
    
    // 店铺信息+配送按钮
    [_shopBtnView loadViewWithStoreInfoArray:orderModel.storeInfoArray orderNumber:orderModel.order_number];
    
    
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
