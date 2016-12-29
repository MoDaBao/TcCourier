//
//  WaitReceiveOrderViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "WaitReceiveOrderViewController.h"
#import "WaitReceiveOrderTableViewCell.h"
#import "TipMessageView.h"
#import "FeHourGlass.h"
#import "WaitReceiveOrderTimeOutTableViewCell.h"

@interface WaitReceiveOrderViewController ()<UITableViewDelegate, UITableViewDataSource, WaitReceiveOrderTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FeHourGlass *hourGlass;

@end

@implementation WaitReceiveOrderViewController


#pragma mark- lazyLoading

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark- 网络请求

- (void)requestData {
    
    NSString *str = [NSString stringWithFormat:@"ad=%@&api=%@&core=%@",[[TcCourierInfoManager shareInstance] getAddressID], @"pdawaitingorder", @"pda"];
    NSDictionary *dic = @{@"api":@"pdawaitingorder", @"core":@"pda", @"ad":[[TcCourierInfoManager shareInstance] getAddressID]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (0 == [dict[@"status"] floatValue]) {
            
            [self.dataArray removeAllObjects];
            
            NSDictionary *dataDic = dict[@"data"];
            for (NSDictionary *orderDic in dataDic[@"order"]) {
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
                [self.tableView headerEndRefreshing];
                if (_hourGlass) {
                    [_hourGlass removeFromSuperview];
                    _hourGlass = nil;
                }
            });
        } else {
            NSLog(@"msg = %@",dict[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}

#pragma mark- 视图方法

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
    WaitReceiveOrderViewController *waitVC = self;
    [self.tableView addHeaderWithCallback:^{
        [waitVC requestData];
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"待接单";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    [self createView];
    
    [self requestData];
    
    
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderInfoModel *orderInfoModel = self.dataArray[indexPath.row];
    CGFloat margin = 5;
    CGFloat height = 0;
    for (StoreInfoModel *storeInfoModel in orderInfoModel.storeInfoArray) {
        height += margin + 15;// icon
        height += margin + [UILabel getHeightByWidth:kScreenWidth - 38 title:[NSString stringWithFormat:@"地址:%@",storeInfoModel.address] font:[UIFont systemFontOfSize:12]];// 地址
        height += margin + [UILabel getHeightByWidth:kScreenWidth - 30 title:[NSString stringWithFormat:@"备注:%@",storeInfoModel.remark] font:kFont14];// 备注
        height += margin + 1;
    }
    
    height += margin + 35;// 配送按钮
    
    
    if ([orderInfoModel.is_timeout isEqualToString:@"1"]) {
        height += 40;
    }
    
    
    return 217 + height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderInfoModel *model = self.dataArray[indexPath.row];
    if ([model.is_timeout isEqualToString:@"1"]) {
        NSString *reuseIdentifier = @"reuse";
        WaitReceiveOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[WaitReceiveOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.delegate = self;
        [cell setDataWithModel:self.dataArray[indexPath.row]];
        return cell;
    } else {
        NSString *reuse = @"reuse1";
        WaitReceiveOrderTimeOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (!cell) {
            cell = [[WaitReceiveOrderTimeOutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        [cell setDataWithModel:self.dataArray[indexPath.row]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = kBGGary;
}


#pragma mark- WaitReceiverCellDelegate

- (void)waitReceiverCellShowTipMessageWithTip:(NSString *)tip {
    // 提示框
    TipMessageView *tipView = [[TipMessageView alloc] initWithTip:[NSString stringWithFormat:@"接单失败,稍后重试"]];
    [self.view addSubview:tipView];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@100);
        make.width.equalTo(@200);
    }];
    [self requestData];
}

- (void)refreshWaitReceive {
    CGFloat height = 100;
    CGFloat width = 100;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - width) * .5, (kScreenHeight - kNavigationBarHeight - height) * .5, width, height)];
    if (!_hourGlass) {
        _hourGlass = [[FeHourGlass alloc] initWithView:view];
        _hourGlass.layer.cornerRadius = 8;
        [self.view addSubview:_hourGlass];
        [_hourGlass mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@100);
            make.center.equalTo(self.view);
        }];
    }
    [_hourGlass showWhileExecutingBlock:^{
        sleep(1);
    } completion:^{
        [self requestData];
    }];
}


#pragma mark- WaitReceiveTimeOutDelegate

- (void)waitReceiverTimeOutCellShowTipMessageWithTip:(NSString *)tip {
    // 提示框
    TipMessageView *tipView = [[TipMessageView alloc] initWithTip:[NSString stringWithFormat:@"接单失败,稍后重试"]];
    [self.view addSubview:tipView];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@100);
        make.width.equalTo(@200);
    }];
    [self requestData];

}
- (void)refreshWaitReceiveTimeOut {
    CGFloat height = 100;
    CGFloat width = 100;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - width) * .5, (kScreenHeight - kNavigationBarHeight - height) * .5, width, height)];
    if (!_hourGlass) {
        _hourGlass = [[FeHourGlass alloc] initWithView:view];
        _hourGlass.layer.cornerRadius = 8;
        [self.view addSubview:_hourGlass];
        [_hourGlass mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@100);
            make.center.equalTo(self.view);
        }];
    }
    [_hourGlass showWhileExecutingBlock:^{
        sleep(1);
    } completion:^{
        [self requestData];
    }];
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
