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
        [_dataArray addObject:@"今日有效单"];
        [_dataArray addObject:@"今日提成"];
        [_dataArray addObject:@"跑腿费(在线支付)"];
        [_dataArray addObject:@"跑腿费(货到付款)"];
        [_dataArray addObject:@"餐品费(在线支付)"];
        [_dataArray addObject:@"餐品费(货到付款)"];
        [_dataArray addObject:@"代购费(在线支付)"];
        [_dataArray addObject:@"代购费(货到付款)"];

    }
    return _dataArray;
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
    
    
    
    [self createView];
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
