//
//  AlreadyDoneViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/26.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "AlreadyDoneViewController.h"
#import "ChooseView.h"
#import "OrderInfoModel.h"
#import "AlredyDoneTableViewCell.h"
#import "OrderDetailViewController.h"

@interface AlreadyDoneViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ChooseView *chooseView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger dayCount;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation AlreadyDoneViewController


#pragma mark -----lazyloading-----

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark -----网络请求-----

- (void)requestData {
    
//    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&day=%@&page=%@&pid=%@",@"pdacomplete", @"pda", [NSString stringWithFormat:@"%ld",(long)_dayCount], @"1", [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
//    NSDictionary *dic = @{@"api":@"pdacomplete", @"core":@"pda", @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId], @"day":[NSString stringWithFormat:@"%ld",(long)_dayCount], @"page":@"1"};
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&day=%@&pid=%@",@"pdacomplete", @"pda", [NSString stringWithFormat:@"%ld",(long)_dayCount], [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdacomplete", @"core":@"pda", @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId], @"day":[NSString stringWithFormat:@"%ld",(long)_dayCount]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dict[@"data"][@"order"];
        if (0 == [dict[@"status"] floatValue]) {
            
//            NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            [self.dataArray removeAllObjects];
            
            for (NSDictionary *orderDic in dataArray) {
                OrderInfoModel *orderModel = [[OrderInfoModel alloc] init];
                [orderModel setValuesForKeysWithDictionary:orderDic];
                NSArray *arr = orderDic[@"store"];
                for (NSDictionary *storedic in arr) {
                    StoreInfoModel *storemodel = [[StoreInfoModel alloc] init];
                    [storemodel setValuesForKeysWithDictionary:storedic];
                    [orderModel.storeInfoArray addObject:storemodel];
                }
                [orderModel.addressInfo setValuesForKeysWithDictionary:orderDic[@"address"]];
                [self.dataArray addObject:orderModel];
            }
            
            // 刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } else {
            NSLog(@"msg = %@",dict[@"msg"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark -----视图方法-----

- (void)createView {
    
    CGFloat chooseW = 80 * kScaleForWidth;
    
    _chooseView = [[ChooseView alloc] init];
    [self.view addSubview:_chooseView];
    [_chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(self.view);
        make.height.equalTo(@(kScreenHeight - kNavigationBarHeight));
        make.width.equalTo(@(chooseW));
    }];
    for (UIView * view in _chooseView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.equalTo(self.view);
        make.height.equalTo(_chooseView);
        make.width.equalTo(@(kScreenWidth - chooseW));
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
    self.navigationItem.title = @"已完成";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _dayCount = 1;// 默认显示今天的单子
    [self requestData];
    
    [self createView];
    
}


#pragma mark -----按钮方法-----

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)click:(UIButton *)btn {
    
    for (UIView *view in _chooseView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button == btn) {
                button.selected = YES;
            } else {
                button.selected = NO;
            }
        }
    }
    
    if (btn.tag == 1000) {// 今日
//        printf("今日");
        _dayCount = 1;
    } else if (btn.tag == 1001) {// 一周内
//        printf("一周内");
        _dayCount = 7;
    } else if (btn.tag == 1002) {// 一个月内
//        printf("一个月内");
        _dayCount = 30;
    } else if (btn.tag == 1003) {// 全部
//        printf("全部");
        _dayCount = 0;
    }
    
    [self requestData];
}


#pragma mark -----tableView代理方法-----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderInfoModel *model = self.dataArray[indexPath.row];
    
    
    CGFloat listViewWidth = tableView.width - (5) * 2 - ((5) * 3 + (18) + [UILabel getWidthWithTitle:@"店家地址:" font:kFont14]);// 计算地址列表视图的宽度
    CGFloat orderInfoLwidth = listViewWidth + [UILabel getWidthWithTitle:@"店家地址:" font:kFont14];
    CGFloat baseH = [UILabel getHeightWithTitle:@"的" font:kFont14];// 一行文字的高度
    
    // 计算支付方式——距离——订单状态 标签高度
    CGFloat orderInfoLHeight = 0;
    if ([model.is_timeout isEqualToString:@"1"]) {
        orderInfoLHeight = [UILabel getHeightByWidth:orderInfoLwidth title:[NSString stringWithFormat:@"%@ - 距%@km - 超时赔付 - %@",model.payment, model.distance, @"已完成"] font:kFont14];
    } else {// 无超时赔付
        orderInfoLHeight = [UILabel getHeightByWidth:orderInfoLwidth title:[NSString stringWithFormat:@"%@ - 距%@km - %@",model.payment, model.distance, @"已完成"] font:kFont14];
    }
    
    // 计算店铺地址的高度
    CGFloat storeHeight = 0;
    for (StoreInfoModel *store in model.storeInfoArray) {
        storeHeight = storeHeight + [UILabel getHeightByWidth:listViewWidth title:store.address font:kFont14] + 5;
    }
    storeHeight -= 5;
    
    // 计算收货地址的高度
    CGFloat receiverHeight = 0;
    AddressInfoModel *address = model.addressInfo;
    receiverHeight = [UILabel getHeightByWidth:listViewWidth title:[NSString stringWithFormat:@"%@%@",address.address, address.detail_addr] font:kFont14];
    
    return 130 + (orderInfoLHeight - baseH) + (storeHeight - baseH) + (receiverHeight - baseH);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"reuse";
    AlredyDoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[AlredyDoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setDataWithModel:self.dataArray[indexPath.row] index:indexPath.row tableWidth:tableView.width];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderInfoModel *model = self.dataArray[indexPath.row];
    OrderDetailViewController *orderVC = [[OrderDetailViewController alloc] init];
    orderVC.orderNumber = model.order_number;
    orderVC.orderStatus = @"已完成";
    [self.navigationController pushViewController:orderVC animated:YES];
    
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
