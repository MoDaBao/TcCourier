//
//  OrderDetailTableViewCell.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/21.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

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
    }
    return self;
}

- (void)setDataWithModel:(OrderInfoModel *)orderModel index:(NSInteger)index {
    
    // 加载 支付方式——距离——订单状态
    if ([orderModel.is_timeout isEqualToString:@"1"]) {// 有超时赔付
        _orderInfoL.text = [NSString stringWithFormat:@"%@ - 距%@km - 超时赔付 - %@",orderModel.payment, orderModel.distance, @"已完成"];
    } else {// 无超时赔付
        _orderInfoL.text = [NSString stringWithFormat:@"%@ - 距%@km - %@",orderModel.payment, orderModel.distance, @"已完成"];
    }
    
    // 加载 订单总额
    NSString *order_price = [NSString stringWithFormat:@"订单总额:￥%@",orderModel.order_price];
    NSMutableAttributedString *order_price_attStr = [[NSMutableAttributedString alloc] initWithString:order_price];
    [order_price_attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,order_price.length - 5)];
    _order_priceL.attributedText = order_price_attStr;
    
    // 加载 跑腿费
    NSString *order_run_fee = [NSString stringWithFormat:@"跑腿费:￥%@",orderModel.order_run_fee];
    NSMutableAttributedString *order_run_fee_attStr = [[NSMutableAttributedString alloc] initWithString:order_run_fee];
    [order_run_fee_attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,order_run_fee.length - 4)];
    _order_run_feeL.attributedText = order_run_fee_attStr;
    
    // 加载餐品费
    NSString *food_price = [NSString stringWithFormat:@"餐品费:￥%@",orderModel.food_price];
    NSMutableAttributedString *food_price_attStr = [[NSMutableAttributedString alloc] initWithString:food_price];
    [food_price_attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,food_price.length - 4)];
    _order_run_feeL.attributedText = food_price_attStr;
    
    // 加载餐盒费
    NSString *box_fee = [NSString stringWithFormat:@"餐盒费:￥%@",orderModel.box_fee];
    NSMutableAttributedString *box_fee_attStr = [[NSMutableAttributedString alloc] initWithString:box_fee];
    [box_fee_attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,box_fee.length - 4)];
    _order_run_feeL.attributedText = box_fee_attStr;
    
    // 加载代购餐品费
    NSString *dai = [NSString stringWithFormat:@"代购餐品费:￥%@",orderModel.dai];
    NSMutableAttributedString *dai_attStr = [[NSMutableAttributedString alloc] initWithString:dai];
    [dai_attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, dai.length - 6)];
    _daigouL.attributedText = dai_attStr;
    
    // 加载总优惠
    NSString *coupon = [NSString stringWithFormat:@"优惠:￥%@",orderModel.dai];
    NSMutableAttributedString *coupon_attStr = [[NSMutableAttributedString alloc] initWithString:dai];
    [coupon_attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, coupon.length - 3)];
    _daigouL.attributedText = coupon_attStr;
    
    // 加载期望送达时间
    _service_timeL.text = [NSString stringWithFormat:@"期望送达时间:%@",orderModel.service_time];
    
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
