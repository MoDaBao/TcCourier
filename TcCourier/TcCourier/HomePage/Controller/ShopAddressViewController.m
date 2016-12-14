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

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation ShopAddressViewController

#pragma mark -----视图方法-----

- (void)createView {
    
    ShoppingInfoView *shopView = [[ShoppingInfoView alloc] initWithShopName:_storeInfoModel.store_name tel:_storeInfoModel.tel distance:@"123123" address:_storeInfoModel.address];
    [self.view addSubview:shopView];
    [shopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.equalTo(@120);
    }];
    
    
//    _mapView = [MAMapView new];
//    [self.view addSubview:_mapView];
//    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(kScreenWidth));
//        make.top.equalTo(@(kNavigationBarHeight));
//        make.bottom.equalTo(shopView.mas_top);
//        make.height.equalTo(@(kScreenHeight - kNavigationBarHeight - shopView.height));
//    }];
//    
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
    self.navigationItem.title = @"商家地址";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [AMapServices sharedServices].apiKey = @"da19e16cdec56b6928db29d74dbd5ee8";
    
    [self createView];
}

#pragma mark -----按钮方法-----

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
