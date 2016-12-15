//
//  WaitReceiveOrderTableViewCell.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "WaitReceiveOrderTableViewCell.h"
#import "TotalAmountAndPaymentView.h"
#import "ReceiverAddressView.h"
#import "RunFeeAndTiFeeView.h"
#import "TimeOutView.h"
#import "ShopView.h"
#import "TipMessageView.h"

@interface WaitReceiveOrderTableViewCell ()

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, strong) UIView *contentV;// 内容视图
@property (nonatomic, strong) UILabel *orderNumberL;// 订单编号
@property (nonatomic, strong) UILabel *orderTimeL;// 订单时间
@property (nonatomic, strong) TotalAmountAndPaymentView *totalAndPaymentView;// 订单总额和支付方式
@property (nonatomic, strong) ReceiverAddressView *receiverAddressView;// 收货人地址
@property (nonatomic, strong) RunFeeAndTiFeeView *runFeeAndTiFeeView;// 跑腿费和跑腿提成

@property (nonatomic, strong) UIView *line4;// 分割线4
@property (nonatomic, strong) TimeOutView *timeOutView;// 超时赔付
@property (nonatomic, strong) ShopView *shopView;// 店铺视图

@property (nonatomic, copy) NSString *order_no;


@end


@implementation WaitReceiveOrderTableViewCell

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
        _line4 = [[UIView alloc] init];
        _line4.backgroundColor = [UIColor blackColor];
        [self.contentV addSubview:_line4];//线是否加
        [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentV);
            make.top.equalTo(_runFeeAndTiFeeView.mas_bottom);
            make.height.equalTo(@(sortaPixel));
        }];
        
        // 超时赔付
        _timeOutView = [TimeOutView new];
        [self.contentV addSubview:_timeOutView];
        [_timeOutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentV);
            make.top.equalTo(_line4.mas_bottom);
            make.height.equalTo(@40);
        }];
        
        // 店铺视图
        _shopView = [ShopView new];
        [self.contentV addSubview:_shopView];
        [_shopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentV);
            make.top.equalTo(_timeOutView.mas_bottom);
            make.height.equalTo(@40);// 临时高度
        }];
        
        // 拒绝订单
        UIButton *acceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentV addSubview:acceptBtn];
        [acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_shopView.mas_bottom).offset(15);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@150);
            make.height.equalTo(@35);
        }];
        [acceptBtn setTitle:@"接受订单" forState:UIControlStateNormal];
        [acceptBtn setBackgroundColor:[UIColor colorWithRed:0.93 green:0.33 blue:0.31 alpha:1.00]];
        [acceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [acceptBtn addTarget:self action:@selector(acceptBtn:) forControlEvents:UIControlEventTouchUpInside];
        acceptBtn.layer.cornerRadius = 5;
        acceptBtn.titleLabel.font = kFont14;
        
        
        
    }
    return self;
}

- (void)setDataWithModel:(OrderInfoModel *)orderModel {
    
    _order_no = orderModel.order_number;
    
    _orderNumberL.text = [NSString stringWithFormat:@"订单编号:%@",orderModel.order_number];// 加载订单编号
    _orderTimeL.text = [NSString stringWithFormat:@"下单时间:%@",orderModel.ctime];// 加载下单时间
    // 加载订单总额和支付方式
    [_totalAndPaymentView loadTotalAmount:orderModel.order_price payment:orderModel.payment];
    // 加载收货人地址
    [_receiverAddressView loadReceiverAddress:orderModel.addressInfo orderNumber:orderModel.order_number];
    // 加载跑腿费和跑腿提成
    [_runFeeAndTiFeeView loadRunFee:orderModel.order_run_fee tiFee:orderModel.ti_run_fee];
    
    // 超时赔付
    if ([orderModel.is_timeout isEqualToString:@"0"]) {// 没有超时赔付
        [_shopView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_line4.mas_bottom);
        }];
        _timeOutView = nil;
    } else {// 有超时赔付
        [_timeOutView loadTimeOut:orderModel.timeout];
    }
    
    // 店铺视图
    [_shopView loadViewWithStoreInfoArray:orderModel.storeInfoArray];
}

// 接单按钮
- (void)acceptBtn:(UIButton *)btn {
    
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&order_no=%@&pid=%@",@"pdagetorder", @"pda", _order_no, [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdagetorder", @"core":@"pda", @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId], @"order_no":_order_no};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (0 == [dict[@"status"] floatValue]) {// 接单成功
            if ([self.delegate respondsToSelector:@selector(waitReceiverCellShowTipMessageWithTip:)]) {
                [self.delegate waitReceiverCellShowTipMessageWithTip:@"接单成功"];
            }
        } else {// 接单失败
            if ([self.delegate respondsToSelector:@selector(waitReceiverCellShowTipMessageWithTip:)]) {
                [self.delegate waitReceiverCellShowTipMessageWithTip:dict[@"msg"]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
    
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
