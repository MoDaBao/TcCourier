//
//  ShopAddressViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/31.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ShopAddressViewController.h"
#import "ShoppingInfoView.h"

@interface ShopAddressViewController ()

@end

@implementation ShopAddressViewController

#pragma mark -----视图方法-----

- (void)createView {
    ShoppingInfoView *shopView = [ShoppingInfoView new];
    [self.view addSubview:shopView];
    [shopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.equalTo(@150);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBGGary;
    
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
