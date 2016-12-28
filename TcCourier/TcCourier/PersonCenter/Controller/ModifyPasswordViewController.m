//
//  ModifyPasswordViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/19.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "MOTextField.h"
#import "TcLoginButton.h"
#import "TipMessageView.h"

@interface ModifyPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) MOTextField *originalTF;
@property (nonatomic, strong) MOTextField *newlyTF;
@property (nonatomic, strong) MOTextField *repeatTF;

@end

@implementation ModifyPasswordViewController

#pragma mark- 视图方法

- (void)createView {
    
    CGFloat margin = 20;
    CGFloat tfHeight = 50;
    CGFloat verticalMargin = 30;
    
    _originalTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, 100, kScreenWidth - margin * 2, tfHeight) bgColor:[UIColor whiteColor] placeholder:@"请输入原密码" lineColor:[UIColor whiteColor] tintColor:kOrangeColor font:kFont14 icon:nil secureTextEntry:YES keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyNext];
    [_originalTF changeBorderWidth:2 borderColor:kOrangeColor];
    _originalTF.tf.delegate = self;
    [self.view addSubview:_originalTF];
    
    _newlyTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, _originalTF.y + tfHeight + verticalMargin, kScreenWidth - margin * 2, tfHeight) bgColor:[UIColor whiteColor] placeholder:@"请输入新密码" lineColor:[UIColor whiteColor] tintColor:kOrangeColor font:kFont14 icon:nil secureTextEntry:YES keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyNext];
    [_newlyTF changeBorderWidth:2 borderColor:kOrangeColor];
    _newlyTF.tf.delegate = self;
    [self.view addSubview:_newlyTF];
    
    _repeatTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, _newlyTF.y + tfHeight + verticalMargin, kScreenWidth - margin * 2, tfHeight) bgColor:[UIColor whiteColor] placeholder:@"请确认新密码" lineColor:[UIColor whiteColor] tintColor:kOrangeColor font:kFont14 icon:nil secureTextEntry:YES keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyDone];
    [_repeatTF changeBorderWidth:2 borderColor:kOrangeColor];
    _repeatTF.tf.delegate = self;
    [self.view addSubview:_repeatTF];
    
    TcLoginButton *modifyBtn = [[TcLoginButton alloc] initWithTitle:@"修改密码" titleColor:[UIColor whiteColor] bgColor:kOrangeColor];
    [modifyBtn addTarget:self action:@selector(modifyPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyBtn];
    [modifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_repeatTF.mas_bottom).offset(50);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.height.equalTo(@40);
    }];
    
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
    self.navigationItem.title = @"修改密码";
    
    [self createView];
    
    // 添加键盘回收手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnKeyboard)];
    [self.view addGestureRecognizer:tap];
}


#pragma mark- 按钮方法

- (void)modifyPwd {
    
    if (self.originalTF.tf.text.length > 0) {// 原始密码不为空
        if ([self.newlyTF.tf.text isEqualToString:self.repeatTF.tf.text]) {// 输入新密码与重复输入新密码一致
            
            if (self.newlyTF.tf.text.length > 0) {// 输入的新密码不为空
                NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&phone=%@&pwd=%@&repwd=%@",@"pdarepwd", @"pda", [[TcCourierInfoManager shareInstance] getCourierPhone], self.originalTF.tf.text, self.repeatTF.tf.text];
                NSDictionary *dic = @{@"api":@"pdarepwd", @"core":@"pda", @"phone":[[TcCourierInfoManager shareInstance] getCourierPhone], @"pwd":self.originalTF.tf.text, @"repwd":self.repeatTF.tf.text};
                NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
                
                AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
                session.requestSerializer = [AFHTTPRequestSerializer serializer];
                session.responseSerializer = [AFHTTPResponseSerializer serializer];
                [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
                [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    if (0 == [dict[@"status"] floatValue]) {// 修改密码成功
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    } else {
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
            } else {// 输入的新密码为空
                // 提示框
                TipMessageView *tipView = [[TipMessageView alloc] initWithTip:@"请先输入新密码"];
                [self.view addSubview:tipView];
                [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self.view);
                    make.height.equalTo(@100);
                    make.width.equalTo(@200);
                }];
            }
            
            
        } else {
            // 提示框
            TipMessageView *tipView = [[TipMessageView alloc] initWithTip:@"新密码两次输入不一致"];
            [self.view addSubview:tipView];
            [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.view);
                make.height.equalTo(@100);
                make.width.equalTo(@200);
            }];
        }
    } else {// 原始密码为空
        // 提示框
        TipMessageView *tipView = [[TipMessageView alloc] initWithTip:@"请先输入密码"];
        [self.view addSubview:tipView];
        [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.height.equalTo(@100);
            make.width.equalTo(@200);
        }];
    }
    
    
    
    
    
}


#pragma mark- 手势方法

/**
 键盘回收
 */
- (void)returnKeyboard {
    [self.view endEditing:YES];
}

#pragma mark- 代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _originalTF.tf) {
        [_newlyTF.tf becomeFirstResponder];
    } else if (textField == _newlyTF.tf) {
        [_repeatTF.tf becomeFirstResponder];
    }
    return YES;
}


#pragma mark- 按钮方法

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
