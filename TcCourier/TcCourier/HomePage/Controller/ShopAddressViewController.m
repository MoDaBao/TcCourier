//
//  ShopAddressViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/31.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ShopAddressViewController.h"
#import "ShoppingInfoView.h"
#import "OrderInfoModel.h"

@interface ShopAddressViewController ()

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) StoreInfoModel *storeInfoModel;

@end

@implementation ShopAddressViewController


#pragma mark -----网络请求-----

- (void)requestData {
    //147859731967
    //147937270420
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&order_no=%@&pid=%@",@"pdaorderinfo", @"pda", _orderNumber, [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdaorderinfo", @"core":@"pda", @"order_no":_orderNumber, @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"dict = %@",dict);
//        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (0 == [dict[@"status"] floatValue]) {
            NSDictionary *dataDic = dict[@"data"][@"order"][0];
            OrderInfoModel *orderInfoModel = [[OrderInfoModel alloc] init];
            [orderInfoModel setValuesForKeysWithDictionary:dataDic];
            [orderInfoModel.addressInfo setValuesForKeysWithDictionary:dataDic[@"address"]];
            for (NSDictionary *storedic in dataDic[@"store"]) {
                StoreInfoModel *storemodel = [[StoreInfoModel alloc] init];
                [storemodel setValuesForKeysWithDictionary:storedic];
                for (NSDictionary *food in dataDic[@"store"][0][@"food"]) {
                    FoodModel *foodModel = [[FoodModel alloc] init];
                    [foodModel setValuesForKeysWithDictionary:food];
                    [storemodel.foodArray addObject:foodModel];
                }
                [orderInfoModel.storeInfoArray addObject:storemodel];
            }
            
            _storeInfoModel = orderInfoModel.storeInfoArray[_index];
            
            // 回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self createView];
            });
        }
        //        NSLog(@"2333");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}

#pragma mark -----视图方法-----

- (void)createView {
    
    ShoppingInfoView *shopView = [[ShoppingInfoView alloc] initWithShopName:_storeInfoModel.store_name tel:_storeInfoModel.tel distance:_storeInfoModel.lng address:_storeInfoModel.address];
    [self.view addSubview:shopView];
    [shopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
//        make.height.equalTo(@120);// 临时高度  高度不用设置 已在自定义初始化方法中添加了高度的约束
    }];
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, 100)];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(kScreenWidth));
        make.top.equalTo(@(kNavigationBarHeight));
        make.bottom.equalTo(shopView.mas_top);
        make.left.and.right.equalTo(self.view);
//        make.height.equalTo(@(kScreenHeight - kNavigationBarHeight - shopView.height));
    }];
    
//    pod 'AMapNavi', '~> 2.1.0'
//    pod 'AMapSearch', '~> 4.1.0'
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
    
    [self requestData];
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
