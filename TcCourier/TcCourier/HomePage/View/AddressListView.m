//
//  StoreListView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/16.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "AddressListView.h"
#import "StoreInfoModel.h"

@interface AddressListView ()

@property (nonatomic, strong) UILabel *tempL;
@property (nonatomic, assign) CGFloat height;

@end

@implementation AddressListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


/**
 加载店铺地址列表
 */
- (void)loadLabelWithArray:(NSArray *)array font:(UIFont *)font width:(CGFloat)width {
    
    for (UILabel *ll in self.subviews) {
        [ll removeFromSuperview];
    }
    
    _height = 0;
    _tempL = nil;
    
    for (StoreInfoModel *s in array) {
        _height = _height + [UILabel getHeightByWidth:width title:s.address font:font];
    }
    
    for (NSInteger i = 0; i < array.count; i ++) {
        StoreInfoModel *store = array[i];
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.font = font;
        label.text = store.address;
        label.numberOfLines = 0;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (0 == i) {
                make.left.and.top.equalTo(self);
            } else {
                make.left.equalTo(self);
                make.top.equalTo(_tempL.mas_bottom).offset(5);
            }
            make.width.equalTo(self);
        }];
        _tempL = label;
        
    }
    _height = _height + (array.count - 1) * 5;
//    NSLog(@"height = %f, width = %f",_height, width);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {// 更新高度的约束
        make.height.equalTo(@(_height));
    }];
    
    
}

/**
 加载收货地址列表
 */
- (void)loadLabelWithAddressInfoModel:(AddressInfoModel *)addressModel font:(UIFont *)font width:(CGFloat)width {
    for (UILabel *ll in self.subviews) {
        [ll removeFromSuperview];
    }
    _height = 0;
    UILabel *label = [UILabel new];
    [self addSubview:label];
    label.font = font;
    label.text = addressModel.detail_addr;
    label.numberOfLines = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.left.and.top.equalTo(self);
    }];
    _height = [UILabel getHeightByWidth:width title:addressModel.detail_addr font:font];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {// 更新高度的约束
        make.height.equalTo(@(_height));
    }];
}

@end
