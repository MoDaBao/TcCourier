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
    
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&order_no=%@&pid=%@",@"pdaorderinfo", @"pda", @"147859731967", [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdaorderinfo", @"core":@"pda", @"order_no":@"147859731967", @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dict = %@",dict);
//        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
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
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"reuse";
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[OrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setDataWithModel:self.dataSourceModel index:indexPath.row];
    return cell;
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
