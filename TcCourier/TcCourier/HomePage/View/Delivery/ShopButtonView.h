//
//  ShopButtonView.h
//  TcCourier
//
//  Created by 莫大宝 on 2016/11/30.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreInfoModel.h"

@protocol ShopButtonViewDelegate <NSObject>

- (void)refreshDeliveryCell;
- (void)showTipMessageViewWithTip:(NSString *)tip;

@end

@interface ShopButtonView : UIView

@property (nonatomic, assign) id<ShopButtonViewDelegate> delegate;

- (void)loadViewWithStoreInfoArray:(NSArray *)storeInfoArray;

@end
