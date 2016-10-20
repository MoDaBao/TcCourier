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

@interface PersonCenterViewController ()<UIAlertViewDelegate>

@end

@implementation PersonCenterViewController

#pragma mark -----视图方法-----

- (void)createView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - KTabBarHeight)];
    //    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    // logo
    CGFloat logoWidth = 60 * kScaleForWidth;
    CGFloat logoHeight = logoWidth / 101 * 139;
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - logoWidth) * 0.5, 100 * kScaleForWidth, logoWidth, logoHeight)];
    logoImageView.image = [UIImage imageNamed:@"chicken-home"];
    [scrollView addSubview:logoImageView];
    
    // 用户名
    NSString *userName = @"配送员";
    UIFont *usernameFont = [UIFont systemFontOfSize:20];
    CGFloat usernameW = [UILabel getWidthWithTitle:userName
                                              font:usernameFont];
    CGFloat usernameH = [UILabel getHeightWithTitle:userName font:usernameFont];
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.width - usernameW) * .5, logoImageView.y + logoHeight + 10, usernameW, usernameH)];
    usernameLabel.text = userName;
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    usernameLabel.font = usernameFont;
    [scrollView addSubview:usernameLabel];
    
    // 总好评率
    CGFloat totalRate = 4.9 / 5.0;// 好评率
    NSString *totalRateStr = [NSString stringWithFormat:@"总好评率%%%02.0f",totalRate * 100];
    UIFont *totalRateFont = [UIFont systemFontOfSize:13];
    CGFloat totalRateW = [UILabel getWidthWithTitle:totalRateStr font:totalRateFont];
    CGFloat totalRateH = [UILabel getHeightWithTitle:totalRateStr font:totalRateFont];
    UILabel *totalRateLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.width - totalRateW) * .5, usernameLabel.y + usernameH + 5, totalRateW, totalRateH)];
    totalRateLabel.text = totalRateStr;
    totalRateLabel.font = totalRateFont;
    [scrollView addSubview:totalRateLabel];
    
    // 总好评率视图
    StarttAppraiseRateView *startRateView = [[StarttAppraiseRateView alloc] initWithFrame:CGRectMake((kScreenWidth - kHeartWidth * 5) * .5, totalRateLabel.y + totalRateH + 10, kHeartWidth * 5, kHeartHeight) goodRate:totalRate];
    [scrollView addSubview:startRateView];
    
    // 设置视图
    SettingView *settingView = [[SettingView alloc] initWithFrame:CGRectMake(0, startRateView.y + startRateView.height + 30, kScreenWidth, 100)];
    [scrollView addSubview:settingView];
    settingView.passwordItem.clickBlock = ^(void) {// 修改密码的block实现
        NSLog(@"^修改密码");
        printf("修改密码");
        ModifyPasswordViewController *modifyVC = [[ModifyPasswordViewController alloc] init];
        [self.navigationController pushViewController:modifyVC animated:YES];
        
    };
    settingView.contactItem.clickBlock = ^(void) {// 联系客服的block实现
        NSLog(@"^联系客服");
        printf("联系客服");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"商服电话:81691580\n工作时间：9:00-19:00" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        alertView.tag = 2333;
        [alertView show];
        
        
    };
    
    // 退出按钮
    CGFloat margin = 40;
    TcLoginButton *logout = [[TcLoginButton alloc] initWithFrame:CGRectMake(margin, settingView.y + settingView.height + 150 * kScaleForWidth, kScreenWidth - margin * 2, 40) title:@"退出登录" titleColor:[UIColor whiteColor] bgColor:[UIColor colorWithRed:83 / 255.0 green:83 / 255.0 blue:83 / 255.0 alpha:1.0]];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:logout];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBGGary;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self createView];
    
}

#pragma mark -----代理方法-----


/**
 alertView代理方法
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2333) {// 联系客服的弹窗
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",@"81691580"]];
            [[UIApplication sharedApplication] openURL:url];
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

- (void)logout {
    
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
