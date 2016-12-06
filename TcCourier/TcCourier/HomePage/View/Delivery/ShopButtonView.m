//
//  ShopButtonView.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/30.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ShopButtonView.h"
#import "ShopAddressViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "DeliveryViewController.h"
#import "TipMessageView.h"

#define kDeliveryBtnBGRed [UIColor colorWithRed:0.93 green:0.33 blue:0.31 alpha:1.00]
#define kDeliveryBtnBGGray [UIColor colorWithRed:0.38 green:0.38 blue:0.39 alpha:1.00]

@interface ShopButtonView ()

@property (nonatomic, strong) NSArray *storeInfoArray;
@property (nonatomic, strong) StoreInfoModel *store;

@end

@implementation ShopButtonView

- (instancetype)init {
    if (self = [super init]) {
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        MainTabBarController *tabVC = (MainTabBarController *)appdelegate.window.rootViewController;
        if (tabVC.selectedIndex == 0) {
            if ([tabVC.homeVc.navigationController.viewControllers.lastObject isKindOfClass:[DeliveryViewController class]]) {
                DeliveryViewController *deliveryVC = (DeliveryViewController *)tabVC.homeVc.navigationController.viewControllers.lastObject;
                self.delegate = deliveryVC;
            }
        }
    }
    return self;
}

- (void)loadViewWithStoreInfoArray:(NSArray *)storeInfoArray {
    
    _storeInfoArray = storeInfoArray;
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    CGFloat height = 0;
    CGFloat margin = 5;
    UIView *temp = nil;
    NSInteger btntag = 1000;
    NSInteger buttontag = 2000;
    for (StoreInfoModel *storeInfoModel in storeInfoArray) {
        UIImageView *icon = [UIImageView new];
        [self addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            if (temp) {
                make.top.equalTo(temp.mas_bottom).offset(margin);
            } else {
                make.top.equalTo(@(margin));
            }
            make.left.equalTo(@(margin));
            make.width.and.height.equalTo(@15);
        }];
        icon.image = [UIImage imageNamed:@"dianpuxinxi"];
        height += 15 + margin;
        
        // 店铺名称
        UILabel *shopNameL = [UILabel new];
        [self addSubview:shopNameL];
        [shopNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon.mas_centerY);
            make.left.equalTo(icon.mas_right).offset(margin);
        }];
        shopNameL.font = kFont14;
        shopNameL.text = storeInfoModel.store_name;
        
        // 地址
        UILabel *addressL = [UILabel new];
        [self addSubview:addressL];
        [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon);
            make.top.equalTo(icon.mas_bottom).offset(margin);
            make.right.equalTo(@(margin));
        }];
        addressL.font = [UIFont systemFontOfSize:12];
        addressL.text = [NSString stringWithFormat:@"地址:%@",storeInfoModel.address];
        height += margin + [UILabel getHeightByWidth:kScreenWidth - 30 title:addressL.text font:addressL.font];
        
        UIImageView *jiantou = [UIImageView new];
        [self addSubview:jiantou];
        CGFloat jiantouW = 8;
        [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-margin));
            // 17 X 29
            make.width.equalTo(@(jiantouW));
            make.height.equalTo(@(jiantouW * 1.0 / 17 * 29));
            make.top.equalTo(addressL.mas_top).offset(-jiantouW * 1.0 / 17 * 29  * .5);
        }];
        jiantou.image = [UIImage imageNamed:@"youbianjian"];
        
        // 备注
        UILabel *remarkL = [UILabel new];
        [self addSubview:remarkL];
        [remarkL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon);
            make.top.equalTo(addressL.mas_bottom).offset(margin);
            make.right.equalTo(@(margin));
        }];
        remarkL.font = kFont14;
        remarkL.numberOfLines = 0;
        remarkL.text = [NSString stringWithFormat:@"备注:%@",storeInfoModel.remark];
        height += margin + [UILabel getHeightByWidth:kScreenWidth - 30 title:remarkL.text font:remarkL.font];
        
        // 配送按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(remarkL.mas_bottom).offset(margin);
            make.height.equalTo(@35);
            make.width.equalTo(@150);
        }];
        btn.layer.cornerRadius = margin;
        [btn setTitle:storeInfoModel.orderStatus forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont14;
        [btn addTarget:self action:@selector(statusBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = btntag++;// 设置tag值
        // 设置按钮背景色
        [self setBtnBGColorWithSotreInfoModel:storeInfoModel btn:btn];
        // 设置按钮标题
        [self setBtnTitleWithStoreInfoModel:storeInfoModel btn:btn];
        
        height += margin + 35;
        
        if (storeInfoModel != [storeInfoArray lastObject]) {
            // 分割线
            float sortaPixel = 1.0 / [UIScreen mainScreen].scale;
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor blackColor];
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(self);
                make.height.equalTo(@(sortaPixel));
                make.top.equalTo(btn.mas_bottom).offset(5);
            }];
            temp = line;
        }
        
        height += margin;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(icon);
            make.right.equalTo(jiantou);
            make.bottom.equalTo(btn.mas_top);
        }];
        [button addTarget:self action:@selector(addressBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = buttontag++;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    
//    self.backgroundColor = [UIColor orangeColor];
}


#pragma mark-----设置按钮的文字和背景颜色-----

// 设置按钮的标题
- (void)setBtnTitleWithStoreInfoModel:(StoreInfoModel *)storeInfoModel btn:(UIButton *)btn {
    if ([storeInfoModel.orderStatus isEqualToString:@"等待跑腿取餐"]) {
        [btn setTitle:@"确认取餐" forState:UIControlStateNormal];
    } else if ([storeInfoModel.orderStatus isEqualToString:@"跑腿正在配送"]) {
        [btn setTitle:@"确认送达" forState:UIControlStateNormal];
    } else if ([storeInfoModel.orderStatus isEqualToString:@"已关闭"]) {
        [btn setTitle:@"商户已取消订单" forState:UIControlStateNormal];
    } else if ([storeInfoModel.orderStatus isEqualToString:@"等待店铺接单"]) {
        [btn setTitle:@"等待商户接单" forState:UIControlStateNormal];
    }
}

// 设置按钮的背景色
- (void)setBtnBGColorWithSotreInfoModel:(StoreInfoModel *)storeInfoModel btn:(UIButton *)btn {
    if ([storeInfoModel.orderStatus isEqualToString:@"等待跑腿取餐"] || [storeInfoModel.orderStatus isEqualToString:@"跑腿正在配送"]) {
        [btn setBackgroundColor:kDeliveryBtnBGRed];
    } else if ([storeInfoModel.orderStatus isEqualToString:@"已关闭"] || [storeInfoModel.orderStatus isEqualToString:@"等待店铺接单"]) {
        [btn setBackgroundColor:kDeliveryBtnBGGray];
    }
}


#pragma mark -----alertView代理方法-----

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 3001) {// 取餐中
        if (buttonIndex == 1) {// 点击确定
            [self requestForTakeMealsWithStoreInfoModel:_store];
        }
    } else if (alertView.tag == 3002) {// 配送中
        if (buttonIndex == 1) {// 点击确定
            [self requestForDeliveryWithStoreInfoModel:_store];
        }
    }
}


#pragma mark-----按钮方法-----

// 配送按钮方法
- (void)statusBtn:(UIButton *)btn {
    _store = _storeInfoArray[btn.tag - 1000];
    if ([_store.orderStatus isEqualToString:@"等待跑腿取餐"]) {// 取餐中
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确认已取餐？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 3001;
        [alert show];
    } else if ([_store.orderStatus isEqualToString:@"跑腿正在配送"]) {// 配送中
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确认已送达？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 3002;
        [alert show];
    } else {
        NSLog(@"点击了按钮");
    }
    
}

// 跳转至地图页面
- (void)addressBtn:(UIButton *)btn {
    StoreInfoModel *store = _storeInfoArray[btn.tag - 2000];
    NSLog(@"跳转至地图页面显示商家地址");
    
    ShopAddressViewController *shopAddressVC = [[ShopAddressViewController alloc] init];
    shopAddressVC.storeInfoModel = store;
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    MainTabBarController *tabVC = (MainTabBarController *)appdelegate.window.rootViewController;
    if (tabVC.selectedIndex == 0) {
        if ([tabVC.homeVc.navigationController.viewControllers.lastObject isKindOfClass:[DeliveryViewController class]]) {
            DeliveryViewController *deliveryVC = (DeliveryViewController *)tabVC.homeVc.navigationController.viewControllers.lastObject;
            [deliveryVC.navigationController pushViewController:shopAddressVC animated:YES];
        }
    }
}


#pragma mark -----网络请求-----

// 取餐
- (void)requestForTakeMealsWithStoreInfoModel:(StoreInfoModel *)storeInfoModel {
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&order_id=%@&pid=%@",@"pdatakefood", @"pda",storeInfoModel.order_id, [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdatakefood", @"core":@"pda", @"order_id":storeInfoModel.order_id, @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (0 == [dict[@"status"] floatValue]) {// 确认取餐成功
                if ([self.delegate respondsToSelector:@selector(refreshDeliveryCell)]) {
                    [self.delegate refreshDeliveryCell];
                }
            } else {
                if ([self.delegate respondsToSelector:@selector(showTipMessageViewWithTip:)]) {
                    [self.delegate showTipMessageViewWithTip:@"确认取餐失败"];
                }
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}

// 送达
- (void)requestForDeliveryWithStoreInfoModel:(StoreInfoModel *)storeInfoModel {
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&order_id=%@&pid=%@",@"pdadelivery", @"pda",storeInfoModel.order_id, [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdadelivery", @"core":@"pda", @"order_id":storeInfoModel.order_id, @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (0 == [dict[@"status"] floatValue]) {// 确认送达成功
                if ([self.delegate respondsToSelector:@selector(refreshDeliveryCell)]) {
                    [self.delegate refreshDeliveryCell];
                }
            } else {
                if ([self.delegate respondsToSelector:@selector(showTipMessageViewWithTip:)]) {
                    [self.delegate showTipMessageViewWithTip:@"确认送达失败"];
                }
            }
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}




@end
