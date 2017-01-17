//
//  DeliveryViewController.h
//  TcCourier
//
//  Created by M on 16/11/2.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeliveryViewControllerDelegate <NSObject>

- (void)setBtnEnabled:(BOOL)isEnabled;

@end

@interface DeliveryViewController : UIViewController

@property (nonatomic, assign) id<DeliveryViewControllerDelegate> delegate;

@end
