//
//  HomePageViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/13.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "HomePageViewController.h"
#import "LoginViewController.h"
#import "HomePageView.h"
#import "TodayCountViewController.h"
#import "WaitReceiveOrderViewController.h"
#import "AlreadyDoneViewController.h"
//#import "ShopAddressViewController.h"
#import "DeliveryViewController.h"
#import "OrderDetailViewController.h"
#import "TipMessageView.h"

@interface HomePageViewController ()

@property (nonatomic, strong) UIButton *workBtn;
@property (nonatomic, strong) UILabel *courierAddress;
@property (nonatomic, strong) HomePageView *homePageView;
@property (nonatomic, assign) BOOL isWork;

@end

@implementation HomePageViewController


#pragma mark- 视图方法

/** 修改上下班按钮图片 **/
- (void)changeWorkBtnImg {
    _isWork = [[[TcCourierInfoManager shareInstance] getTcCourierOnlineStatus] boolValue];
    if (_isWork) {// 如果为1 在线
        [_workBtn setBackgroundImage:[UIImage imageNamed:@"work"] forState:UIControlStateNormal];
        if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {//定位功能可用
            _courierAddress.text = [[[TcCourierInfoManager shareInstance] getCourierAddress] isEqualToString:@" "] ? @"上班中，正在定位" : [[TcCourierInfoManager shareInstance] getCourierAddress];
        } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {//定位不能用
            _courierAddress.text = @"定位失败，请先开启定位功能";
        }
        
    } else {
        [_workBtn setBackgroundImage:[UIImage imageNamed:@"workout"] forState:UIControlStateNormal];
        _courierAddress.text = @"下班了";
    }
}

// 创建UI视图
- (void)createView {
    // 上下班按钮
    CGFloat workMargin = 15;
    CGFloat workW = 50 * kScaleForWidth;
    CGFloat workH = 23 * kScaleForWidth;
    CGFloat workX = kScreenWidth - workW - workMargin;
    CGFloat workY = 30;
    self.workBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.workBtn.frame = CGRectMake(workX, workY, workW, workH);
    [self.workBtn setBackgroundImage:[UIImage imageNamed:@"workout"] forState:UIControlStateNormal];
    [self.workBtn addTarget:self action:@selector(work) forControlEvents:UIControlEventTouchUpInside];
    self.workBtn.adjustsImageWhenHighlighted = NO;// 关闭按钮的高亮效果
    [self.view addSubview:self.workBtn];
    
    // 地址
    CGFloat addressW = kScreenWidth * 2 / 3;
    CGFloat addressH = 20;
    self.courierAddress = [[UILabel alloc] initWithFrame:CGRectMake(workMargin, _workBtn.y + _workBtn.height * .5 - addressH * .5, addressW, addressH)];
    self.courierAddress.font = [UIFont systemFontOfSize:14 * kScaleForWidth];
    self.courierAddress.text = @"下班了";
    [self.view addSubview:self.courierAddress];
    
    
    // logo
    CGFloat logoWidth = 60 * kScaleForWidth;
    CGFloat logoHeight = logoWidth / 101 * 139;
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - logoWidth) * 0.5, self.workBtn.y + self.workBtn.height + 50, logoWidth, logoHeight)];
    logoImageView.image = [UIImage imageNamed:@"chicken-home"];
    [self.view addSubview:logoImageView];
    
    
    self.homePageView = [[HomePageView alloc] initWithFrame:CGRectMake(0, logoImageView.y + logoHeight + 50, kScreenWidth, 190)];
    self.homePageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.homePageView];
    
    
    [self addBlockAchive];// 给_homePageView添加Block实现
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    if ([[[TcCourierInfoManager shareInstance] getTcCourierUserId] isEqualToString:@" "]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
    [self changeWorkBtnImg];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBGGary;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self createView];

}


#pragma mark- Appdelegate代理方法

- (void)setAddress:(NSString *)address {
    
    if (self.isWork == YES) {
        self.courierAddress.text = address;
    }
    
}


#pragma mark- 手势代理方法

/**
 右滑返回手势代理方法
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count == 1) {// 关闭主界面的右滑返回
        return NO;
    } else {
        return YES;
    }
}


#pragma mark- 按钮方法


/**
 上下班方法
 */
- (void)work {
    
    _isWork = !_isWork;
    
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&pid=%@&status=%@",@"pdastatus", @"pda", [[TcCourierInfoManager shareInstance] getTcCourierUserId], [NSString stringWithFormat:@"%d",_isWork]];
    NSDictionary *dic = @{@"api":@"pdastatus", @"core":@"pda", @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId], @"status":[NSString stringWithFormat:@"%d",_isWork]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"dict = %@",dict[@"msg"]);
        if (0 == [dict[@"status"] floatValue]) {// 请求成功
            // 更新本地存储的在线状态
            [[TcCourierInfoManager shareInstance] saveTcCourierOnlineStatus:[NSString stringWithFormat:@"%d", _isWork]];
            [self changeWorkBtnImg];
            
        } else {
            _isWork = !_isWork;
            // 提示框
            TipMessageView *tipView = [[TipMessageView alloc] initWithTip:dict[@"msg"]];
            [self.view addSubview:tipView];
            [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.view);
                make.height.equalTo(@100);
                make.width.equalTo(@200);
            }];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
    
    
    
    
}

// 测试按钮的测试方法
- (void)test {
    OrderDetailViewController *orderVC = [[OrderDetailViewController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
    orderVC.orderNumber = @"147859731967";
    

    
    
}

// 给homepageView中的每个item添加block实现
- (void)addBlockAchive {
    HomePageItemView *daijiedan = [self.homePageView viewWithTag:1000];
    daijiedan.clickBlock = ^ () {
        WaitReceiveOrderViewController *waitVC = [[WaitReceiveOrderViewController alloc] init];
        [self.navigationController pushViewController:waitVC animated:YES];
    };// 待接单
    HomePageItemView *peisongzhong = [self.homePageView viewWithTag:1001];
    peisongzhong.clickBlock = ^() {
        DeliveryViewController *deliveryVC = [[DeliveryViewController alloc] init];
        [self.navigationController pushViewController:deliveryVC animated:YES];
    };// 配送中
        HomePageItemView *yiwancheng = [self.homePageView viewWithTag:1002];
    yiwancheng.clickBlock = ^() {
        AlreadyDoneViewController *alreadyVC = [[AlreadyDoneViewController alloc] init];
        [self.navigationController pushViewController:alreadyVC animated:YES];
    };// 已完成
    HomePageItemView *jinritongji = [self.homePageView viewWithTag:1003];
    jinritongji.clickBlock = ^() {
        TodayCountViewController *todayVC = [[TodayCountViewController alloc] init];
        [self.navigationController pushViewController:todayVC animated:YES];
    };// 今日统计
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
