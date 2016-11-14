//
//  AlreadyDoneViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/26.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "AlreadyDoneViewController.h"
#import "ChooseView.h"

@interface AlreadyDoneViewController ()

@property (nonatomic, strong) ChooseView *chooseView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AlreadyDoneViewController


#pragma mark -----网络请求-----

- (void)requestData {
    
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&pid=%@&day=%@",@"pdacomplete", @"pda", [[TcCourierInfoManager shareInstance] getTcCourierUserId], @"0"];
    NSDictionary *dic = @{@"api":@"pdacomplete", @"core":@"pda", @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId], @"day":@"0"};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark -----视图方法-----

- (void)createView {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _chooseView = [[ChooseView alloc] init];
    [self.view addSubview:_chooseView];
    [_chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(self.view);
        make.height.equalTo(@(kScreenHeight - kNavigationBarHeight));
        make.width.equalTo(@90);
    }];
    for (UIView * view in _chooseView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.equalTo(self.view);
        make.height.equalTo(_chooseView);
        make.width.equalTo(@(kScreenWidth - 90));
    }];
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(_chooseView.width, kNavigationBarHeight, kScreenWidth - _chooseView.width, _chooseView.height) style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.tableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBGGary;
    self.navigationItem.title = @"已完成";
    
    [self createView];
    
}


#pragma mark -----按钮方法-----

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)click:(UIButton *)btn {
    
    for (UIView *view in _chooseView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button == btn) {
                button.selected = YES;
            } else {
                button.selected = NO;
            }
        }
    }
    
    if (btn.tag == 1000) {// 今日
//        printf("今日");
    } else if (btn.tag == 1001) {// 一周内
//        printf("一周内");
    } else if (btn.tag == 1002) {// 一个月内
//        printf("一个月内");
    } else if (btn.tag == 1003) {// 全部
//        printf("全部");
    }
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
