//
//  FoodListView.h
//  TcCourier
//
//  Created by M on 2016/11/22.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@interface FoodListView : UIView

//- (instancetype)initWithFoodArray:(NSArray *)foodArray;
- (void)loadDataWithFoodArray:(NSArray *)foodArray;

@end
