//
//  TodayCountViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/17.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TodayCountViewController.h"
#import "TodayInfoView.h"

@interface TodayCountViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation TodayCountViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark -----网络请求-----

- (void)requestData {
    
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&pid=%@",@"pdastatistical", @"pda", [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdastatistical", @"core":@"pda", @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (0 == [dict[@"status"] floatValue]) {// 请求成功
            
            [self.dataArray addObject:@{@"今日有效单":dict[@"data"][@"count"]}];
            [self.dataArray addObject:@{@"今日提成":dict[@"data"][@"ti"]}];
            [self.dataArray addObject:@{@"跑腿费(在线支付)":dict[@"data"][@"ponline"]}];
            [self.dataArray addObject:@{@"跑腿费(货到付款)":dict[@"data"][@"punline"]}];
            [self.dataArray addObject:@{@"餐品费(在线支付)":dict[@"data"][@"fonline"]}];
            [self.dataArray addObject:@{@"餐品费(货到付款)":dict[@"data"][@"funonline"]}];
            [self.dataArray addObject:@{@"代购费(在线支付)":dict[@"data"][@"donline"]}];
            [self.dataArray addObject:@{@"代购费(货到付款)":dict[@"data"][@"dunonline"]}];
            
            // 更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self createView];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}


#pragma mark -----视图方法——----

- (void)createView {
    
    TodayInfoView *infoView = [[TodayInfoView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight + 50, kScreenWidth, 330 * kScaleForWidth) dataArray:self.dataArray];
    infoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:infoView];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
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
    self.navigationItem.title = @"今日统计";
    
    [self requestData];
    
    
}

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
