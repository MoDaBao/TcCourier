//
//  LoginViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/13.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "LoginViewController.h"
#import "MOTextField.h"
#import "TcLoginButton.h"
#import "TipMessageView.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) MOTextField *phoneTF;
@property (nonatomic, strong) MOTextField *passwordTF;
@property (nonatomic, strong) TcLoginButton *loginBtn;
@property (nonatomic, assign) BOOL isWork;

@end

@implementation LoginViewController


#pragma mark -----视图方法-----

/**
 创建视图
 */
- (void)createView {
    
    CGFloat margin = 30;
    CGFloat contentMargin = margin / 3 * 4;
    UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(contentMargin, 150 * kScaleForHeight, kScreenWidth - contentMargin * 2, 230)];
    contentV.layer.cornerRadius = 10;
    contentV.layer.borderColor = kOrangeColor.CGColor;
    contentV.layer.borderWidth = 1;
    contentV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentV];
    
    _phoneTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, 80, contentV.width - margin * 2, 30) bgColor:[UIColor whiteColor] placeholder:@"请输入您的账号" lineColor:kOrangeColor tintColor:kOrangeColor font:kFont14 icon:[UIImage imageNamed:@"account"] secureTextEntry:NO keyboardType:UIKeyboardTypeNumberPad returnKeyType:UIReturnKeyNext];
    _phoneTF.tf.delegate = self;
    [contentV addSubview:_phoneTF];
    
    _passwordTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, 140, contentV.width - margin * 2, 30) bgColor:[UIColor whiteColor] placeholder:@"请输入您的密码" lineColor:kOrangeColor tintColor:kOrangeColor font:kFont14 icon:[UIImage imageNamed:@"password"] secureTextEntry:YES keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyDone];
    [contentV addSubview:_passwordTF];
    
    CGFloat logoW = 80 * kScaleForWidth;
    CGFloat logoH = logoW;
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(contentMargin + contentV.width * .5 - logoW * .5, contentV.y - logoH * .5, logoW, logoH)];
    logo.image = [UIImage imageNamed:@"avatar"];
    [self.view addSubview:logo];
    
    _loginBtn = [[TcLoginButton alloc] initWithFrame:CGRectMake(contentMargin, contentV.y + contentV.height + 60, contentV.width, 40) title:@"登录" titleColor:[UIColor whiteColor] bgColor:kOrangeColor];
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


#pragma mark -----按钮方法-----

- (void)login {
    
    
    if (self.phoneTF.tf.text.length > 0) {// 账号不为空
        if (self.passwordTF.tf.text.length > 0) {// 密码不为空
            NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&phone=%@&pwd=%@",@"pdalogin", @"pda", _phoneTF.tf.text, _passwordTF.tf.text];
            NSDictionary *dic = @{@"api":@"pdalogin", @"core": @"pda", @"phone":_phoneTF.tf.text,  @"pwd":_passwordTF.tf.text};
            
            NSDictionary *parameterDic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
            
            
            AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
            session.requestSerializer = [AFHTTPRequestSerializer serializer];
            session.responseSerializer = [AFHTTPResponseSerializer serializer];
            [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
            [session POST:REQUEST_URL parameters:parameterDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (0 == [dict[@"status"] floatValue]) {// 登录成功
                    
                    NSMutableDictionary *dataDic = dict[@"data"][@"pda"];
                    dataDic[@"phone"] = dict[@"data"][@"phone"];
                    
                    // 存储登录跑腿信息
                    [[TcCourierInfoManager shareInstance] setTcCourierInfoWithDic:dataDic];
                    
                    // 刷新UI
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                } else {// 登录失败
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
                NSLog(@"failed:%@", error);
            }];
        } else {
            // 提示框
            TipMessageView *tipView = [[TipMessageView alloc] initWithTip:@"密码不能为空"];
            [self.view addSubview:tipView];
            [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.view);
                make.height.equalTo(@100);
                make.width.equalTo(@200);
            }];
        }
    } else {
        // 提示框
        TipMessageView *tipView = [[TipMessageView alloc] initWithTip:@"账号不能为空"];
        [self.view addSubview:tipView];
        [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.height.equalTo(@100);
            make.width.equalTo(@200);
        }];
    }
    
    
    
    
    
    
}


#pragma mark ----键盘回收手势方法-----

- (void)returnKeyBoard {
    [self.view endEditing:YES];
}


#pragma mark -----代理方法-----

// 限制输入位数11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *str = [NSString stringWithFormat:@"%@%@",textField.text, string];
    if (str.length > 11) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if (textField == _phoneTF.tf) {
//        [_passwordTF.tf becomeFirstResponder];
//    }
    [self login];
    return YES;
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
