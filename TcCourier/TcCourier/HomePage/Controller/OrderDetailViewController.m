//
//  OrderDetailViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/11/4.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"

@interface OrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderInfoModel *dataSourceModel;

@end

@implementation OrderDetailViewController


#pragma mark -----LazyLoading-----

- (OrderInfoModel *)dataSourceModel {
    if (!_dataSourceModel) {
        _dataSourceModel = [[OrderInfoModel alloc] init];
    }
    return _dataSourceModel;
}



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
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (0 == [dict[@"status"] floatValue]) {
            NSDictionary *dataDic = dict[@"data"][@"order"][0];
            [self.dataSourceModel setValuesForKeysWithDictionary:dataDic];
            [self.dataSourceModel.addressInfo setValuesForKeysWithDictionary:dataDic[@"address"]];
            for (NSDictionary *storedic in dataDic[@"store"]) {
                StoreInfoModel *storemodel = [[StoreInfoModel alloc] init];
                [storemodel setValuesForKeysWithDictionary:storedic];
                for (NSDictionary *food in dataDic[@"store"][0][@"food"]) {
                    FoodModel *foodModel = [[FoodModel alloc] init];
                    [foodModel setValuesForKeysWithDictionary:food];
                    [storemodel.foodArray addObject:foodModel];
                }
                [self.dataSourceModel.storeInfoArray addObject:storemodel];
            }
            
            // 回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_tableView) {
                    [self.tableView reloadData];
                } else {
                    [self createView];
                }
            });
            
            
        }
//        NSLog(@"2333");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}

#pragma mark -----视图方法-----


- (void)createView {
    // 加载tableView
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kBGGary;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBGGary;
    self.navigationItem.title = @"订单详情";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
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


#pragma mark -----tableView代理方法-----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat margin = 5;
    
    // 计算地址列表视图的宽度
    CGFloat addressViewWidth = kScreenWidth - 20 - margin * 2 - [UILabel getWidthWithTitle:@"店家地址:" font:kFont14];
    
    // 计算店铺地址的高度
    CGFloat storeHeight = 0;
    for (StoreInfoModel *store in self.dataSourceModel.storeInfoArray) {
        storeHeight += [UILabel getHeightByWidth:addressViewWidth title:store.address font:kFont14] + 5;
    }
    storeHeight -= 5;
    
    // 计算收货地址的高度
    CGFloat receiverHeight = 0;
    AddressInfoModel *address = self.dataSourceModel.addressInfo;
    receiverHeight = [UILabel getHeightByWidth:addressViewWidth title:[NSString stringWithFormat:@"%@%@",address.address, address.detail_addr] font:kFont14];
    
    // 计算shopname的宽度
    CGFloat shopNameWidth = (kScreenWidth - 20) * .35;
    
    // 计算foodname的宽度
    CGFloat foodNameWidth = (kScreenWidth - 20 - margin * 2 - 15 - shopNameWidth - margin) *  .4;
    
    // 分割线高度
    float sortaPixel = 1.0 / [UIScreen mainScreen].scale;
    
    // 店铺-餐品详情
    CGFloat foodDetailHeight = 0;
    for (StoreInfoModel *storeModel in self.dataSourceModel.storeInfoArray) {
        foodDetailHeight += 5;// icon与上面分割线的距离
        CGFloat shopNameHeight = [UILabel getHeightByWidth:shopNameWidth title:storeModel.store_name font:kFont14];// 商店名标签的高度
        CGFloat foodHeight = 0;
        for (FoodModel *food in storeModel.foodArray) {
            foodHeight += [UILabel getHeightByWidth:foodNameWidth title:food.title font:kFont14] + 5;// 累加食物名称的高度和间隔
        }
        foodHeight -= 5;// 减掉多加了一次的间隔高度
        foodDetailHeight += (shopNameHeight > foodHeight ? shopNameHeight : foodHeight);// 判断是shopName的高度大还是食物列表高度大
        foodDetailHeight += sortaPixel + 5;
        foodDetailHeight += [UILabel getHeightByWidth:kScreenWidth - 20 - 20 title:[NSString stringWithFormat:@"备注:%@",storeModel.remark] font:kFont14];// 加上备注的高度
        foodDetailHeight += 5 + sortaPixel;
        
        foodDetailHeight += 5;
    }
    
//    return 355 + storeHeight + receiverHeight + foodDetailHeight;
    return 239 + storeHeight + receiverHeight + foodDetailHeight + 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"reuse";
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[OrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setDataWithModel:self.dataSourceModel index:indexPath.row orderStatus:_orderStatus];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = kBGGary;
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
