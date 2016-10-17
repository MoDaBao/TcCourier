//
//  LoginViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/13.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "LoginViewController.h"
#import "MOTextField.h"

@interface LoginViewController ()

@property (nonatomic, strong) MOTextField *phoneTF;
@property (nonatomic, strong) MOTextField *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, assign) BOOL isWork;

@end

@implementation LoginViewController


#pragma mark -----按钮方法-----

- (void)login {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -----视图方法-----

- (void)createView {
    
    CGFloat margin = 30;
    CGFloat contentMargin = margin / 3 * 4;
    UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(contentMargin, 150 * kScaleForHeight, kScreenWidth - contentMargin * 2, 230)];
    contentV.layer.cornerRadius = 10;
    contentV.layer.borderColor = kOrangeColor.CGColor;
    contentV.layer.borderWidth = 1;
    contentV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentV];
    
    _phoneTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, 80, contentV.width - margin * 2, 30) placeholder:@"请输入您的账号" lineColor:kOrangeColor tintColor:kOrangeColor font:[UIFont systemFontOfSize:14] icon:[UIImage imageNamed:@"account"] secureTextEntry:NO keyboardType:UIKeyboardTypeNumberPad returnKeyType:UIReturnKeyNext];
    [contentV addSubview:_phoneTF];
    
    _passwordTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, 140, contentV.width - margin * 2, 30) placeholder:@"请输入您的密码" lineColor:kOrangeColor tintColor:kOrangeColor font:[UIFont systemFontOfSize:14] icon:[UIImage imageNamed:@"password"] secureTextEntry:YES keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyDone];
    [contentV addSubview:_passwordTF];
    
    CGFloat logoW = 80 * kScaleForWidth;
    CGFloat logoH = logoW;
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(contentMargin + contentV.width * .5 - logoW * .5, contentV.y - logoH * .5, logoW, logoH)];
    logo.image = [UIImage imageNamed:@"avatar"];
    [self.view addSubview:logo];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(contentMargin, contentV.y + contentV.height + 60, contentV.width, 40);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:kOrangeColor];
    _loginBtn.layer.cornerRadius = _loginBtn.height * .5;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _loginBtn.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影颜色
    _loginBtn.layer.shadowOffset = CGSizeMake(1, 1);// 阴影范围
    _loginBtn.layer.shadowRadius = 4;// 阴影半径
    _loginBtn.layer.shadowOpacity = .5;// 阴影透明度
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_loginBtn];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBGGary;
    
    [self createView];
    
    // 添加键盘回收手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
}

#pragma mark ----手势方法-----

- (void)returnKeyBoard {
    [self.view endEditing:YES];
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
