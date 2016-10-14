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

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MOTextField *textField = [[MOTextField alloc] initWithFrame:CGRectMake(100, 100, 200, 30) placeholder:@"ceshi" lineColor:[UIColor redColor] tintColor:[UIColor orangeColor] font:[UIFont systemFontOfSize:14] icon:[UIImage imageNamed:@"123.jpg"]];
    [self.view addSubview:textField];
    
    
    MOTextField *text = [[MOTextField alloc] initWithFrame:CGRectMake(100, 200, 200, 30) placeholder:@"test" lineColor:[UIColor orangeColor] tintColor:[UIColor orangeColor] font:[UIFont systemFontOfSize:14] icon:nil];
    [self.view addSubview:text];
    
    
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
