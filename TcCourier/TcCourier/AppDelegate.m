//
//  AppDelegate.m
//  TcCourier
//
//  Created by M on 16/10/13.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "PersonCenterViewController.h"
#import "MainTabBarController.h"
#import "WaitReceiveOrderViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()<JPUSHRegisterDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *jPushOrderNumber;

@end

@implementation AppDelegate


#pragma mark- AppDelegate方法

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 设置根视图控制器
    MainTabBarController *mainTabVC = [[MainTabBarController alloc] init];
    self.window.rootViewController = mainTabVC;
    
    // 设置高德SDK的key
    [AMapServices sharedServices].apiKey = @"da19e16cdec56b6928db29d74dbd5ee8";
    [self setLocationManager];
    
    // 设置极光
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction advertisingIdentifier:nil];
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];// 收到自定义消息时调用networkDidReceiveMessage:方法
    [defaultCenter addObserver:self selector:@selector(networkDidLoginSuccess:) name:kJPFNetworkDidLoginNotification object:nil];// 登录成功时调用networkDidLoginSuccess: 方法
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark- 高德

- (void)setLocationManager {
    
    // 定位
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    //设置允许后台定位参数，保持不会被系统挂起
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];//iOS9(含)以上系统需设置
    [self.locationManager startUpdatingLocation];// 开启持续定位
    
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    //定位错误
    NSLog(@"定位错误 %s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    //定位结果
    //    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    // 保存定位得到的经纬度
    [[TcCourierInfoManager shareInstance] saveLatitude:[NSString stringWithFormat:@"%f",location.coordinate.latitude]];
    [[TcCourierInfoManager shareInstance] saveLongitude:[NSString stringWithFormat:@"%f",location.coordinate.longitude]];
    
//    // 保存测试使用的温岭的经纬度
//    [[TcCourierInfoManager shareInstance] saveLatitude:@"28.389418"];
//    [[TcCourierInfoManager shareInstance] saveLongitude:@"121.363678"];
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(sendCourierAddressAndRemindOrder) userInfo:nil repeats:YES];
        
    }
    
    AMapReGeocodeSearchRequest *reGeo = [[AMapReGeocodeSearchRequest alloc] init];
    reGeo.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    reGeo.radius = 200;
    reGeo.requireExtension = YES;
    //发起逆向地理编码
    [_search AMapReGoecodeSearch:reGeo];
    
    
}

/* 逆地理编码回调. */ //在定位SDK版本更新到2.2以上之前  暂时先用search对象发起逆地理编码
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode) {
        if ([self.addressDelegate respondsToSelector:@selector(setAddress:)]) {
            NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@%@",response.regeocode.addressComponent.district, response.regeocode.addressComponent.township, response.regeocode.addressComponent.neighborhood, response.regeocode.addressComponent.building, response.regeocode.addressComponent.streetNumber.street, response.regeocode.addressComponent.streetNumber.number];
            [[TcCourierInfoManager shareInstance] saveCourierAddress:address];
            [self.addressDelegate setAddress:address];
        }
    }
    
}

//高德定位SDK2.2 以上的版本直接用这个代理方法进行反地理编码，不需要用search对象发起反地理编码
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
//
//    [[TcCourierInfoManager shareInstance] saveLatitude:[NSString stringWithFormat:@"%f",location.coordinate.latitude]];
//    [[TcCourierInfoManager shareInstance] saveLongitude:[NSString stringWithFormat:@"%f",location.coordinate.longitude]];
////    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
//    if (reGeocode) {
//        NSLog(@"reGeocode:%@", reGeocode);
//    }
//}


#pragma mark- 定时器方法

- (void)sendCourierAddressAndRemindOrder {
    [self sendCourierAddress];
    [self remindOrder];
}

/**
 上传跑腿当前位置
 */
- (void)sendCourierAddress {
    // 当用户登录并且为在线状态的时候上传当前登录跑腿的位置
    if (![[[TcCourierInfoManager shareInstance] getTcCourierUserId] isEqualToString:@" "] && [[[TcCourierInfoManager shareInstance] getTcCourierOnlineStatus] isEqualToString:@"1"]) {
        
        if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
            //定位功能可用
            if (![[[TcCourierInfoManager shareInstance] getLatitude] isEqualToString:@" "] && ![[[TcCourierInfoManager shareInstance] getLongitude] isEqualToString:@" "]) {
                NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&lati=%@&longt=%@&pid=%@",@"pdacoordinates", @"pda", [[TcCourierInfoManager shareInstance] getLatitude], [[TcCourierInfoManager shareInstance] getLongitude], [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
                NSDictionary *dic = @{@"api":@"pdacoordinates", @"core":@"pda", @"lati":[[TcCourierInfoManager shareInstance] getLatitude], @"longt":[[TcCourierInfoManager shareInstance] getLongitude], @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
                NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
                
                AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
                session.requestSerializer = [AFHTTPRequestSerializer serializer];
                session.responseSerializer = [AFHTTPResponseSerializer serializer];
                [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
                [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    //        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    if (0 == [dict[@"status"] floatValue]) {
                        NSLog(@"上传位置成功");
                    } else {
                        NSLog(@"上传位置失败");
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"error is %@",error);
                }];
            }
        } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//            //定位不能用
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先开启定位功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
        }
    }

}

- (void)remindOrder {
    NSString *str = [NSString stringWithFormat:@"ad=%@&api=%@&core=%@",[[TcCourierInfoManager shareInstance] getAddressID], @"pdawaitingorder", @"pda"];
    NSDictionary *dic = @{@"api":@"pdawaitingorder", @"core":@"pda", @"ad":[[TcCourierInfoManager shareInstance] getAddressID]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (0 == [dict[@"status"] floatValue]) {
            NSDictionary *orderDic = dict[@"data"][@"order"];
            if (orderDic.count) {// 有未接单的单子
                
                UIViewController *vc = [UIViewController getCurrentViewController];
                if (![vc isKindOfClass:[WaitReceiveOrderViewController class]]) {// 如果当前为待接单页面不需要弹窗提醒
                    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前有可接订单" delegate:self cancelButtonTitle:@"前去抢单" otherButtonTitles:nil, nil];
                    alertV.tag = 6789;
                    [alertV show];
                    
                    [self pushNotificationWithMessage:@"当前有可接订单，前去抢单"];
                }
                
            }
            
        } else {
            NSLog(@"msg = %@",dict[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}


#pragma mark- 极光

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

// 收到自定义消息时  在此方法中处理消息
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSDictionary *content = [userInfo valueForKey:@"content"];
    if ([content respondsToSelector:@selector(objectForKey:)]) {
        _jPushOrderNumber = content[@"order_number"];
        if (1 == [[[TcCourierInfoManager shareInstance] getTcCourierOnlineStatus] floatValue] && ![[[TcCourierInfoManager shareInstance] getTcCourierUserId] isEqualToString:@" "]) {// 当前为登录+在线状态
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前有新订单，前去抢单" delegate:self cancelButtonTitle:@"前去抢单" otherButtonTitles:nil, nil];
            alertV.tag = 7890;
            [alertV show];
            
            [self pushNotificationWithMessage:@"当前有新订单，前去抢单"];
            
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"极光发送了一条测试消息，请忽略" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
//    // 测试
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"64e6" message:@"53w5" delegate:nil cancelButtonTitle:@"test" otherButtonTitles:nil, nil];
//    [alert show];
    
}

// 极光登录成功时
- (void)networkDidLoginSuccess:(NSNotification *)notification {
    NSString *alias = [NSString stringWithFormat:@"tcjpda%@",[[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    [JPUSHService setAlias:alias callbackSelector:nil object:nil];// 注册别名
}


#pragma mark- AlertView代理方法

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 7890) {
        if (_jPushOrderNumber) {
            WaitReceiveOrderViewController *waitVC = [[WaitReceiveOrderViewController alloc] init];
            waitVC.isJpush = YES;
            waitVC.orderNumber = _jPushOrderNumber;
            UIViewController *vc = [UIViewController getCurrentViewController];
            [vc.navigationController pushViewController:waitVC animated:YES];
        }
    } else if (alertView.tag == 6789) {
        WaitReceiveOrderViewController *waitVC = [[WaitReceiveOrderViewController alloc] init];
        waitVC.isJpush = NO;
        UIViewController *vc = [UIViewController getCurrentViewController];
        [vc.navigationController pushViewController:waitVC animated:YES];
    }
    
    
}


#pragma mark- 发送本地通知并有震动和声音

- (void)pushNotificationWithMessage:(NSString *)message {
    /** 加上声音和震动提示 如果在后台要有推送 **/
    
    // 系统声音
    AudioServicesPlaySystemSound(1007);
    // 震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    
    // 测试推送
    UILocalNotification *localnotification;
    if (!localnotification) {
        localnotification = [[UILocalNotification alloc]init];
    }
    
    localnotification.repeatInterval = 0;
    /**
     *  设置推送的相关属性
     */
    localnotification.alertBody = message;//通知具体内容
    localnotification.soundName = UILocalNotificationDefaultSoundName;//通知时的音效
    NSDictionary *dit_noti = [NSDictionary dictionaryWithObject:@"affair.schedule" forKey:@"id"];
    localnotification.userInfo = dit_noti;
    
    /**
     *  调度本地通知,通知会在特定时间发出
     */
    [[UIApplication sharedApplication] presentLocalNotificationNow:localnotification];
}

@end



