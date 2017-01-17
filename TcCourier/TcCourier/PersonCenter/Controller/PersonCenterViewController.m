//
//  PersonCenterViewController.m
//  TcCourier
//
//  Created by M on 16/10/13.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "StarttAppraiseRateView.h"
#import "SettingView.h"
#import "TcLoginButton.h"
#import "ModifyPasswordViewController.h"
#import "LoginViewController.h"
#import "PersonCenterView.h"

@interface PersonCenterViewController ()<UIAlertViewDelegate>

@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *ordercount;
@property (nonatomic, copy) NSString *ordertimeout;
@property (nonatomic, strong) NSString *timeout;
@property (nonatomic, strong) PersonCenterView *personView;
@property (nonatomic, strong) UILabel *totalRateLabel;
@property (nonatomic, strong) StarttAppraiseRateView *startRateView;
@property (nonatomic, strong) UILabel *userNameL;
           
@end

@implementation PersonCenterViewController


#pragma mark- 网络请求

- (void)requestData {
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&pid=%@",@"pdainfo", @"pda", [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdainfo", @"core":@"pda", @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (0 == [dict[@"status"] floatValue]) {
            NSDictionary *dataDic = dict[@"data"][@"pda"];
            _score = dataDic[@"score"];
            [[TcCourierInfoManager shareInstance] saveScore:_score];// 更新socre
            _ordercount = dataDic[@"ordercount"];
            _ordertimeout = dataDic[@"ordertimeout"];
            _timeout = dataDic[@"timeout"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateView];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}


#pragma mark- 视图方法

- (void)updateView {
    // 有效单数
    _personView.effectiveOrderL.text = [NSString stringWithFormat:@"%@单",_ordercount];
    // 超时赔付单数
    _personView.timeoutCountL.text = [NSString stringWithFormat:@"%@单",_ordertimeout];
    // 超时赔付百分比
    _personView.timeoutPercentageL.text = [NSString stringWithFormat:@"%.2f%%",_timeout.floatValue * 100];
    // 总好评率
    _totalRateLabel.text = [NSString stringWithFormat:@"总好评率%%%02.0f",_score.floatValue / 5.0 * 100];
    // 总好评率视图
    [_startRateView updateGoodRateWith:_score.floatValue / 5.0];
    // 用户名
    _userNameL.text = [NSString stringWithFormat:@"%@",[[TcCourierInfoManager shareInstance] getTcCourierUserName]];
    
}

- (void)createView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - KTabBarHeight)];
    scrollView.contentSize = CGSizeMake(scrollView.width, scrollView.height);
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    // logo
    CGFloat logoWidth = 60 * kScaleForWidth;
    CGFloat logoHeight = logoWidth / 101 * 139;
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - logoWidth) * 0.5, 55 * kScaleForWidth, logoWidth, logoHeight)];
    logoImageView.image = [UIImage imageNamed:@"chicken-home"];
    [scrollView addSubview:logoImageView];
    
    // 用户名
    NSString *userName = [[TcCourierInfoManager shareInstance] getTcCourierUserName];
    UIFont *usernameFont = [UIFont systemFontOfSize:20];
//    CGFloat usernameW = [UILabel getWidthWithTitle:userName font:usernameFont];
    CGFloat usernameH = [UILabel getHeightWithTitle:userName font:usernameFont];
    _userNameL = [[UILabel alloc] initWithFrame:CGRectMake(0, logoImageView.y + logoHeight + 5, kScreenWidth, usernameH)];
//    _userNameL = [UILabel new];
    _userNameL.text = userName;
    _userNameL.textAlignment = NSTextAlignmentCenter;
    _userNameL.font = usernameFont;
    [scrollView addSubview:_userNameL];
//    [_userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(logoImageView.mas_bottom);
//    }];
    
    // 总好评率
    CGFloat totalRate = [[[TcCourierInfoManager shareInstance] getScore] floatValue] / 5.0;// 好评率
    NSString *totalRateStr = [NSString stringWithFormat:@"总好评率%%%02.0f",totalRate * 100];
    UIFont *totalRateFont = [UIFont systemFontOfSize:13];
//    CGFloat totalRateW = [UILabel getWidthWithTitle:totalRateStr font:totalRateFont];
    CGFloat totalRateH = [UILabel getHeightWithTitle:totalRateStr font:totalRateFont];
    _totalRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _userNameL.y + usernameH + 5, kScreenWidth, totalRateH)];
    _totalRateLabel.textAlignment = NSTextAlignmentCenter;
    _totalRateLabel.text = totalRateStr;
    _totalRateLabel.font = totalRateFont;
    [scrollView addSubview:_totalRateLabel];
    
    // 总好评率视图
    _startRateView = [[StarttAppraiseRateView alloc] initWithFrame:CGRectMake((kScreenWidth - kHeartWidth * 5) * .5, _totalRateLabel.y + totalRateH + 5, kHeartWidth * 5, kHeartHeight) goodRate:totalRate];
    [scrollView addSubview:_startRateView];
    
//    // 设置视图
//    SettingView *settingView = [[SettingView alloc] initWithFrame:CGRectMake(0, startRateView.y + startRateView.height + 30, kScreenWidth, 100)];
//    [scrollView addSubview:settingView];
//    settingView.passwordItem.clickBlock = ^(void) {// 修改密码的block实现
//        ModifyPasswordViewController *modifyVC = [[ModifyPasswordViewController alloc] init];
//        [self.navigationController pushViewController:modifyVC animated:YES];
//        
//    };
//    settingView.contactItem.clickBlock = ^(void) {// 联系客服的block实现
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"商服电话:81691580\n工作时间：9:00-19:00" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
//        alertView.tag = 2333;
//        [alertView show];
//    };
    
    _personView = [[PersonCenterView alloc] initWithOrderCount:@"123" ordertimeout:@"123" timeout:@"0.5"];
    [self.view addSubview:_personView];
    [_personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(self.view);
        make.top.equalTo(_startRateView.mas_bottom).offset(5);
        make.height.equalTo(@235);
    }];
    PersonCenterViewController *personVC = self;
    _personView.modifyBlock = ^(void) {
        ModifyPasswordViewController *modifyVC = [[ModifyPasswordViewController alloc] init];
        [personVC.navigationController pushViewController:modifyVC animated:YES];
    };
    _personView.contactBlock = ^ (void) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"客服电话:81691580\n工作时间：9:00-19:00" delegate:personVC cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        alertView.tag = 2333;
        [alertView show];
    };
    
    
    
    // 退出按钮
//    CGFloat margin = 40;
//    CGFloat btnH = 40;
    TcLoginButton *logout = [[TcLoginButton alloc] initWithTitle:@"退出登录" titleColor:[UIColor whiteColor] bgColor:[UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1.00]];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:logout];
    [logout mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(personView.mas_bottom).offset(45 * kScaleForHeight);
        make.left.equalTo(scrollView.mas_left).offset(40);
//        make.right.equalTo(@-40);
        make.width.equalTo(@(kScreenWidth - 80));
//        make.right.equalTo(scrollView)
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80 * kScaleForHeight);
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    [self requestData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBGGary;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self createView];
    
}

#pragma mark- 代理方法


/**
 alertView代理方法
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2333) {// 联系客服的弹窗
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"81691580"]];
            [[UIApplication sharedApplication] openURL:url];
        }
    } else if (alertView.tag == 2334) { // 退出登录的弹窗
        if (1 == buttonIndex) {// 点击确定
            // 删除用户的登录信息
            [[TcCourierInfoManager shareInstance] removeAllTcCourierInfo];
            [JPUSHService setAlias:@" " callbackSelector:nil object:nil];
            // 弹出登录页面
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }
    }
}


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
 退出登录
 */
- (void)logout {
    
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出登录吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertV.tag = 2334;
    [alertV show];
    
    
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
