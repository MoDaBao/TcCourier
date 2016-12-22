//
//  PersonCenterViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/13.
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
           
@end

@implementation PersonCenterViewController


#pragma mark-----网络请求-----

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
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (0 == [dict[@"status"] floatValue]) {
            NSDictionary *dataDic = dict[@"data"][@"pda"];
            _score = dataDic[@"score"];
            _ordercount = dataDic[@"ordercount"];
            _ordertimeout = dataDic[@"ordertimeout"];
            _timeout = dataDic[@"timeout"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self createView];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}


#pragma mark -----视图方法-----

- (void)createView {
    
    
    for (UIView *v in self.view.subviews) {
        [v removeFromSuperview];
    }
    
    
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
    CGFloat usernameW = [UILabel getWidthWithTitle:userName
                                              font:usernameFont];
    CGFloat usernameH = [UILabel getHeightWithTitle:userName font:usernameFont];
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.width - usernameW) * .5, logoImageView.y + logoHeight + 5, usernameW, usernameH)];
    usernameLabel.text = userName;
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    usernameLabel.font = usernameFont;
    [scrollView addSubview:usernameLabel];
    
    // 总好评率
    CGFloat totalRate = _score.floatValue / 5.0;// 好评率
    NSString *totalRateStr = [NSString stringWithFormat:@"总好评率%%%02.0f",totalRate * 100];
    UIFont *totalRateFont = [UIFont systemFontOfSize:13];
    CGFloat totalRateW = [UILabel getWidthWithTitle:totalRateStr font:totalRateFont];
    CGFloat totalRateH = [UILabel getHeightWithTitle:totalRateStr font:totalRateFont];
    UILabel *totalRateLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.width - totalRateW) * .5, usernameLabel.y + usernameH + 5, totalRateW, totalRateH)];
    totalRateLabel.text = totalRateStr;
    totalRateLabel.font = totalRateFont;
    [scrollView addSubview:totalRateLabel];
    
    // 总好评率视图
    StarttAppraiseRateView *startRateView = [[StarttAppraiseRateView alloc] initWithFrame:CGRectMake((kScreenWidth - kHeartWidth * 5) * .5, totalRateLabel.y + totalRateH + 5, kHeartWidth * 5, kHeartHeight) goodRate:totalRate];
    [scrollView addSubview:startRateView];
    
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
    
    PersonCenterView *personView = [[PersonCenterView alloc] initWithOrderCount:_ordercount ordertimeout:_ordertimeout timeout:_timeout];
    [self.view addSubview:personView];
    [personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(self.view);
        make.top.equalTo(startRateView.mas_bottom).offset(5);
        make.height.equalTo(@235);
    }];
    personView.modifyBlock = ^(void) {
        ModifyPasswordViewController *modifyVC = [[ModifyPasswordViewController alloc] init];
        [self.navigationController pushViewController:modifyVC animated:YES];
    };
    personView.contactBlock = ^ (void) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"商服电话:81691580\n工作时间：9:00-19:00" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
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
    
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self requestData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBGGary;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

#pragma mark -----代理方法-----


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


#pragma mark -----按钮方法-----


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
