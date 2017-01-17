//
//  SettingItemView.h
//  TcCourier
//
//  Created by M on 16/10/19.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(void);


@interface SettingItemView : UIView

@property (nonatomic, copy) ClickBlock clickBlock;

- (instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray *)itemArray;


@end
