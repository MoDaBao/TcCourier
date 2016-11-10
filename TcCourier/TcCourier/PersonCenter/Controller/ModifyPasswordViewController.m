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

@interface ModifyPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) MOTextField *originalTF;
@property (nonatomic, strong) MOTextField *newlyTF;
@property (nonatomic, strong) MOTextField *repeatTF;

@end

@implementation ModifyPasswordViewController

#pragma mark ----视图方法----

- (void)createView {
    
    CGFloat margin = 20;
    CGFloat tfHeight = 50;
    CGFloat verticalMargin = 30;
    
    _originalTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, 100, kScreenWidth - margin * 2, tfHeight) bgColor:[UIColor whiteColor] placeholder:@"请输入原密码" lineColor:[UIColor whiteColor] tintColor:kOrangeColor font:[UIFont systemFontOfSize:14] icon:nil secureTextEntry:YES keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyNext];
    [_originalTF changeBorderWidth:2 borderColor:kOrangeColor];
    _originalTF.tf.delegate = self;
    [self.view addSubview:_originalTF];
    
    _newlyTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, _originalTF.y + tfHeight + verticalMargin, kScreenWidth - margin * 2, tfHeight) bgColor:[UIColor whiteColor] placeholder:@"请输入新密码" lineColor:[UIColor whiteColor] tintColor:kOrangeColor font:[UIFont systemFontOfSize:14] icon:nil secureTextEntry:YES keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyNext];
    [_newlyTF changeBorderWidth:2 borderColor:kOrangeColor];
    _newlyTF.tf.delegate = self;
    [self.view addSubview:_newlyTF];
    
    _repeatTF = [[MOTextField alloc] initWithFrame:CGRectMake(margin, _newlyTF.y + tfHeight + verticalMargin, kScreenWidth - margin * 2, tfHeight) bgColor:[UIColor whiteColor] placeholder:@"请确认新密码" lineColor:[UIColor whiteColor] tintColor:kOrangeColor font:[UIFont systemFontOfSize:14] icon:nil secureTextEntry:YES keyboardType:UIKeyboardTypeDefault returnKeyType:UIReturnKeyDone];
    [_repeatTF changeBorderWidth:2 borderColor:kOrangeColor];
    _repeatTF.tf.delegate = self;
    [self.view addSubview:_repeatTF];
    
    TcLoginButton *modifyBtn = [[TcLoginButton alloc] initWithFrame:CGRectMake(40, _repeatTF.y + tfHeight + 60, kScreenWidth - 40 * 2, 40) title:@"修改密码" titleColor:[UIColor whiteColor] bgColor:kOrangeColor];
    [modifyBtn addTarget:self action:@selector(modifyPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyBtn];
    
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


#pragma mark -----按钮方法-----

- (void)modifyPwd {
    
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&phone=%@&pwd=%@&repwd=%@",@"pdarepwd", @"pda", @"13333333333", @"1234567", @"456789"];
    NSDictionary *dic = @{@"api":@"pdarepwd", @"core":@"pda", @"phone":@"13333333333", @"pwd":@"1234567", @"repwd":@"456789"};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        NSLog(@"msg = %@",responseObject[@"msg"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
    
}


#pragma mark-----手势方法-----

/**
 键盘回收
 */
- (void)returnKeyboard {
    [self.view endEditing:YES];
}

#pragma mark -----代理方法-----

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _originalTF.tf) {
        [_newlyTF.tf becomeFirstResponder];
    } else if (textField == _newlyTF.tf) {
        [_repeatTF.tf becomeFirstResponder];
    }
    return YES;
}


#pragma mark -----按钮方法-----

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
