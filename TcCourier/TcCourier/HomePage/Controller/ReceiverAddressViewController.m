//
//  ReceiverAddressViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/12/2.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ReceiverAddressViewController.h"


@interface ReceiverAddressViewController ()

@property (nonatomic, strong) MAMapView *mapView;


@end

@implementation ReceiverAddressViewController


#pragma mark -----视图方法-----

- (void)createView {
//    _mapView = [MAMapView new];
//    [self.view addSubview:_mapView];
//    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self.view);
//        make.top.equalTo(@(kNavigationBarHeight));
//        make.bottom.equalTo(self.view);
//    }];
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
    self.navigationItem.title = @"收货地址";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [AMapServices sharedServices].apiKey = @"da19e16cdec56b6928db29d74dbd5ee8";
    
    [self createView];
    
//    NSLog(@"address = %@ \n log = %@ \n lati = %@",_addressInfoModel.address, _addressInfoModel.longitudeG, _addressInfoModel.latitudeG);
    
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
