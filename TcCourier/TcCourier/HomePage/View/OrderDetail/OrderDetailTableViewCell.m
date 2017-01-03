//
//  OrderDetailTableViewCell.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/21.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "OrderDetailTableViewCell.h"
#import "AddressListView.h"
#import "OrderDetailShopListView.h"

@interface OrderDetailTableViewCell ()

@property (nonatomic, strong) UIView *contentV;

@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, strong) UILabel *orderInfoL;// 支付方式——距离——订单状态
@property (nonatomic, strong) UILabel *order_priceL;// 订单总额
@property (nonatomic, strong) UILabel *order_run_feeL;// 跑腿费
@property (nonatomic, strong) UILabel *food_priceL;// 餐品费
@property (nonatomic, strong) UILabel *box_feeL;// 餐盒费
@property (nonatomic, strong) UILabel *daigouL;// 代购餐品费
@property (nonatomic, strong) UILabel *couponL;// 总优惠
@property (nonatomic, strong) UILabel *service_timeL;// 期望送达时间
@property (nonatomic, strong) UILabel *receiverL;// 收货人
@property (nonatomic, strong) UILabel *receiverPhoneL;// 收货人电话
@property (nonatomic, strong) AddressListView *storeAddressListV;// 商家地址列表
@property (nonatomic, strong) AddressListView *receiverAddressListV;// 收货地址列表
@property (nonatomic, strong) OrderDetailShopListView *orderDetailShopListView;// 商家-餐品详情列表
@property (nonatomic, strong) UILabel *orderNumberL;// 订单编号
@property (nonatomic, strong) UILabel *orderTimeL;// 下单时间
@property (nonatomic, strong) UILabel *arriveTimeL;// 跑腿送达时间

@property (nonatomic, strong) UIView *line2;// 收货地址 下面的分割线
@property (nonatomic, strong) UILabel *shouhuodizhi;

@property (nonatomic, copy) NSString *phone;

@end

@implementation OrderDetailTableViewCell

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
        
        // 支付方式——距离——订单状态
        _orderInfoL = [UILabel new];
        [self.contentV addSubview:_orderInfoL];
        _orderInfoL.font = kFont14;
        _orderInfoL.numberOfLines = 0;
        [_orderInfoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(_margin));
            make.left.equalTo(@(_margin));
            make.right.equalTo(self.contentV);
        }];
        
        // 订单总额
        _order_priceL = [UILabel new];
        [self.contentV addSubview:_order_priceL];
        _order_priceL.font = kFont14;
        [_order_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_orderInfoL);
            make.top.equalTo(_orderInfoL.mas_bottom).offset(_margin);
        }];
        
        // 跑腿费
        _order_run_feeL = [UILabel new];
        [self.contentV addSubview:_order_run_feeL];
        _order_run_feeL.font = kFont14;
        [_order_run_feeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_order_priceL);
            make.top.equalTo(_order_priceL.mas_bottom).offset(_margin);
        }];
        
        // 餐品费
        _food_priceL = [UILabel new];
        [self.contentV addSubview:_food_priceL];
        _food_priceL.font = kFont14;
        [_food_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_order_run_feeL);
            make.top.equalTo(_order_run_feeL.mas_bottom).offset(_margin);
        }];
        
        // 餐盒费
        _box_feeL = [UILabel new];
        [self.contentV addSubview:_box_feeL];
        _box_feeL.font = kFont14;
        [_box_feeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_food_priceL);
            make.top.equalTo(_food_priceL.mas_bottom).offset(_margin);
        }];
        
        // 代购餐品费
        _daigouL = [UILabel new];
        [self.contentV addSubview:_daigouL];
        _daigouL.font = kFont14;
        [_daigouL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_box_feeL);
            make.top.equalTo(_box_feeL.mas_bottom).offset(_margin);
        }];
        
        // 总优惠
        _couponL = [UILabel new];
        [self.contentV addSubview:_couponL];
        _couponL.font = kFont14;
        [_couponL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_daigouL);
            make.top.equalTo(_daigouL.mas_bottom).offset(_margin);
        }];
        
        // 期望送达时间
        _service_timeL = [UILabel new];
        [self.contentV addSubview:_service_timeL];
        _service_timeL.font = kFont14;
        [_service_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_couponL);
            make.top.equalTo(_couponL.mas_bottom).offset(_margin);
        }];
        
        // 分割线
        float sortaPixel = 1.0 / [UIScreen mainScreen].scale;
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = [UIColor lightGrayColor];
        [self.contentV addSubview:line1];//线是否加
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentV);
            make.top.equalTo(_service_timeL.mas_bottom).offset(_margin);
            make.height.equalTo(@(sortaPixel));
        }];
        
        // 收货人
        _receiverL = [UILabel new];
        [self.contentV addSubview:_receiverL];
        _receiverL.font = kFont14;
        [_receiverL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_couponL);
            make.top.equalTo(line1.mas_bottom).offset(_margin);
        }];
        
        // 收货人电话
        _receiverPhoneL = [UILabel new];
        [self.contentV addSubview:_receiverPhoneL];
        _receiverPhoneL.font = kFont14;
        [_receiverPhoneL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_receiverL);
            make.right.equalTo(self.contentV).offset(-20);
        }];
        
        // 店家地址标签
        UILabel *dianjiadizhi = [UILabel new];
        dianjiadizhi.text = @"店家地址:";
        [self.contentV addSubview:dianjiadizhi];
        dianjiadizhi.font = kFont14;
        [dianjiadizhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_receiverL);
            make.top.equalTo(_receiverL.mas_bottom).offset(_margin);
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
//        _storeAddressListV.backgroundColor = [UIColor redColor];
        
        // 收货地址标签
        _shouhuodizhi = [UILabel new];
        _shouhuodizhi.text = @"收货地址:";
        [self.contentV addSubview:_shouhuodizhi];
        _shouhuodizhi.font = kFont14;
        [_shouhuodizhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(dianjiadizhi);
            make.top.equalTo(_storeAddressListV.mas_bottom).offset(_margin);
            make.width.equalTo(@([UILabel getWidthWithTitle:_shouhuodizhi.text font:kFont14]));
        }];
        
        // 收货地址列表标签
        _receiverAddressListV = [AddressListView new];
        [self.contentV addSubview:_receiverAddressListV];
        [_receiverAddressListV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_storeAddressListV);
            make.top.equalTo(_shouhuodizhi);
            make.right.equalTo(self.contentV);
            make.height.equalTo(@10);
        }];
//        _receiverAddressListV.backgroundColor = [UIColor yellowColor];
        
        // 分割线
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor lightGrayColor];
        [self.contentV addSubview:_line2];//线是否加
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentV);
            make.top.equalTo(_receiverAddressListV.mas_bottom).offset(_margin);
            make.height.equalTo(@(sortaPixel));
        }];
        
        // 商家-餐品详情列表
        _orderDetailShopListView = [OrderDetailShopListView new];
        [self.contentV addSubview:_orderDetailShopListView];
        [_orderDetailShopListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentV);
            make.top.equalTo(_line2.mas_bottom);
            make.height.equalTo(@10);// 临时高度
        }];
//        _orderDetailShopListView.backgroundColor = [UIColor orangeColor];
        
        // 订单编号
        _orderNumberL = [UILabel new];
        [self.contentV addSubview:_orderNumberL];
        _orderNumberL.font = kFont14;
        [_orderNumberL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_shouhuodizhi);
            make.top.equalTo(_orderDetailShopListView.mas_bottom).offset(_margin);
        }];
        
        // 下单时间
        _orderTimeL = [UILabel new];
        [self.contentV addSubview:_orderTimeL];
        _orderTimeL.font = kFont14;
        [_orderTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_orderNumberL);
            make.top.equalTo(_orderNumberL.mas_bottom).offset(_margin);
        }];
        
        // 跑腿送达时间
        _arriveTimeL = [UILabel new];
        [self.contentV addSubview:_arriveTimeL];
        _arriveTimeL.font = kFont14;
        [_arriveTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_orderTimeL);
            make.top.equalTo(_orderTimeL.mas_bottom).offset(_margin);
        }];
    }
    return self;
}

- (void)setDataWithModel:(OrderInfoModel *)orderModel index:(NSInteger)index orderStatus:(NSString *)orderStatus {
    
    // 加载 支付方式——距离——订单状态
    if ([orderModel.is_timeout isEqualToString:@"1"]) {// 有超时赔付
        _orderInfoL.text = [NSString stringWithFormat:@"%@ - 距%@km - 超时赔付 - %@",orderModel.payment, orderModel.distance, orderStatus];
    } else {// 无超时赔付
        _orderInfoL.text = [NSString stringWithFormat:@"%@ - 距%@km - %@",orderModel.payment, orderModel.distance, orderStatus];
    }
    
    // 加载 订单总额
    [self setAttStrWithlabel:_order_priceL title:@"订单总额:" sum:[NSString stringWithFormat:@"￥%@",orderModel.order_price]];
    
    // 加载 跑腿费
    [self setAttStrWithlabel:_order_run_feeL title:@"跑腿费:" sum:[NSString stringWithFormat:@"￥%@",orderModel.order_run_fee]];
    
    // 加载餐品费
    [self setAttStrWithlabel:_food_priceL title:@"餐品费:" sum:[NSString stringWithFormat:@"￥%@",orderModel.food_price]];
    
    // 加载餐盒费
    [self setAttStrWithlabel:_box_feeL title:@"餐盒费:" sum:[NSString stringWithFormat:@"￥%@",orderModel.box_fee]];
    
    // 加载代购餐品费
    [self setAttStrWithlabel:_daigouL title:@"代购餐品费:" sum:[NSString stringWithFormat:@"￥%@",orderModel.dai]];
    
    // 加载总优惠
    [self setAttStrWithlabel:_couponL title:@"优惠:" sum:[NSString stringWithFormat:@"￥%@",orderModel.coupon]];
    
    // 加载期望送达时间
    _service_timeL.text = [NSString stringWithFormat:@"期望送达时间:%@",orderModel.service_time];
    
    // 加载 收货人
    _receiverL.text = [NSString stringWithFormat:@"收货人: %@",orderModel.addressInfo.name];
    
    // 加载 收货人号码
    if (![orderStatus isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"收货号码: %@",orderModel.addressInfo.mobile];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.18 green:0.61 blue:0.58 alpha:1.00] range:NSMakeRange(6,orderModel.addressInfo.mobile.length)];
        [attStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(6,orderModel.addressInfo.mobile.length)];
        _receiverPhoneL.attributedText = attStr;
        
        _phone = orderModel.addressInfo.mobile;
        
        // 拨号
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.contentV addSubview:btn];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(_receiverPhoneL);
//        }];
//        [btn addTarget:self action:@selector(bohao) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    // 加载店铺地址
    [_storeAddressListV loadLabelWithArray:orderModel.storeInfoArray font:_orderInfoL.font width:(kScreenWidth - 20 - 5 * 2 - [UILabel getWidthWithTitle:@"店铺地址:" font:kFont14])];
    
    // 加载收货地址
    [_receiverAddressListV loadLabelWithAddressInfoModel:orderModel.addressInfo font:_orderInfoL.font width:(kScreenWidth - 20 - 5 * 2 - [UILabel getWidthWithTitle:@"收货地址:" font:kFont14])];
//    if (orderModel.addressInfo.address.length == 0) {
//        [_line2 mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_shouhuodizhi.mas_bottom).offset(_margin);
//        }];
//        _line2.backgroundColor = [UIColor redColor];
//    }
    
    // 加载 商家-餐品详情列表
    [_orderDetailShopListView loadOrderShopDetailListViewWithSotreInfoArray:orderModel.storeInfoArray];
    
    // 加载订单编号
    _orderNumberL.text = [NSString stringWithFormat:@"订单编号:%@",orderModel.order_number];
    
    // 加载下单时间
    _orderTimeL.text = [NSString stringWithFormat:@"下单时间:%@",orderModel.ctime];
    
    // 加载 跑腿送达时间
    _arriveTimeL.text = [NSString stringWithFormat:@"跑腿送达时间:%@",orderModel.pda_finly];
    
}


/**
 设置价格富文本

 @param label 需要设置富文本的标签对象
 @param title 例如 订单总额:
 @param sum 例如 ￥10.00
 */
- (void)setAttStrWithlabel:(UILabel *)label title:(NSString *)title sum:(NSString *)sum {
    NSString *str = [NSString stringWithFormat:@"%@%@",title, sum];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.80 green:0.15 blue:0.15 alpha:1.00] range:NSMakeRange(title.length,str.length - title.length)];
    label.attributedText = attStr;
}

// 计算_orderShopDetailListView的高度
- (void)getOrderShopDetailListViewHeightWithStoreArray:(NSArray *)sotreArray {
    
}


/**
 拨号方法
 */
- (void)bohao {
    if (_phone.length > 0) {
        NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",self.phone]; //而这个方法则打电话前先弹框  是否打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
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
