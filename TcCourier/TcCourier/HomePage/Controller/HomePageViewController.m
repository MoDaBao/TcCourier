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

@interface HomePageViewController ()

@property (nonatomic, strong) UIButton *workBtn;
@property (nonatomic, strong) UILabel *courierAddress;
@property (nonatomic, strong) HomePageView *homePageView;

@end

@implementation HomePageViewController


#pragma mark -----视图方法-----

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
    [self.workBtn setBackgroundImage:[UIImage imageNamed:@"work"] forState:UIControlStateNormal];
    [self.workBtn addTarget:self action:@selector(work) forControlEvents:UIControlEventTouchUpInside];
    self.workBtn.adjustsImageWhenHighlighted = NO;// 关闭按钮的高亮效果
    [self.view addSubview:self.workBtn];
    
    // 地址
    CGFloat addressW = kScreenWidth * 2 / 3;
    CGFloat addressH = 20;
    self.courierAddress = [[UILabel alloc] initWithFrame:CGRectMake(workMargin, _workBtn.y + _workBtn.height * .5 - addressH * .5, addressW, addressH)];
    self.courierAddress.font = [UIFont systemFontOfSize:14 * kScaleForWidth];
    self.courierAddress.text = @"上班中";
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBGGary;
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
    
    [self createView];
    
    
    
}

#pragma mark -----按钮方法-----

- (void)work {
    
}

// 给homepageView中的每个item添加block实现
- (void)addBlockAchive {
    HomePageItemView *daijiedan = [self.homePageView viewWithTag:1000];
    daijiedan.clickBlock = ^ () {
        NSLog(@"待接单");
    };// 待接单
    HomePageItemView *peisongzhong = [self.homePageView viewWithTag:1001];
    peisongzhong.clickBlock = ^() {
        NSLog(@"配送中");
    };// 配送中
        HomePageItemView *yiwancheng = [self.homePageView viewWithTag:1002];
    yiwancheng.clickBlock = ^() {
        NSLog(@"已完成");
        
    };// 已完成
    HomePageItemView *jinritongji = [self.homePageView viewWithTag:1003];
    jinritongji.clickBlock = ^() {
        NSLog(@"今日统计");
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
