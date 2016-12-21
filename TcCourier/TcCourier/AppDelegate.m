//
//  AppDelegate.m
//  TcCourier
//
//  Created by 莫大宝 on 16/10/13.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "PersonCenterViewController.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AppDelegate

#pragma mark -----高德-----

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
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    //定位结果
//    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    [[TcCourierInfoManager shareInstance] saveLatitude:[NSString stringWithFormat:@"%f",location.coordinate.latitude]];
    [[TcCourierInfoManager shareInstance] saveLongitude:[NSString stringWithFormat:@"%f",location.coordinate.longitude]];
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(sendCourierAddress) userInfo:nil repeats:YES];
        
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
            [self.addressDelegate setAddress:[NSString stringWithFormat:@"%@%@%@%@%@%@",response.regeocode.addressComponent.district, response.regeocode.addressComponent.township, response.regeocode.addressComponent.neighborhood, response.regeocode.addressComponent.building, response.regeocode.addressComponent.streetNumber.street, response.regeocode.addressComponent.streetNumber.number]];
        }
    }
    
}

//高德定位SDK2.2 以上的版本直接用这个代理方法进行反地理编码
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
//    
//    [[TcCourierInfoManager shareInstance] saveLatitude:[NSString stringWithFormat:@"%f",location.coordinate.latitude]];
//    [[TcCourierInfoManager shareInstance] saveLongitude:[NSString stringWithFormat:@"%f",location.coordinate.longitude]];
////    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
//    if (reGeocode) {
//        NSLog(@"reGeocode:%@", reGeocode);
//    }
//}


#pragma mark -----定时器方法-----

- (void)sendCourierAddress {
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&lati=%@&longt=%@&pid=%@",@"pdacoordinates", @"pda", [[TcCourierInfoManager shareInstance] getLatitude], [[TcCourierInfoManager shareInstance] getLongitude], [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdacoordinates", @"core":@"pda", @"lati":[[TcCourierInfoManager shareInstance] getLatitude], @"longt":[[TcCourierInfoManager shareInstance] getLongitude], @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (0 == [dict[@"status"] floatValue]) {
//            NSLog(@"")
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
}

#pragma mark -----AppDelegate方法-----

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    MainTabBarController *mainTabVC = [[MainTabBarController alloc] init];
    self.window.rootViewController = mainTabVC;
    
    // 设置高德SDK的key
    [AMapServices sharedServices].apiKey = @"da19e16cdec56b6928db29d74dbd5ee8";
    [self setLocationManager];
    
    [self.window makeKeyAndVisible];
    return YES;
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
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
