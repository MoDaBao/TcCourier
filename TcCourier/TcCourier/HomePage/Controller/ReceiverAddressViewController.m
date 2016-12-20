//
//  ReceiverAddressViewController.m
//  TcCourier
//
//  Created by 莫大宝 on 2016/12/2.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "ReceiverAddressViewController.h"
#import "OrderInfoModel.h"
#import "SelectableOverlay.h"
#import "ReceiverAddressInfoView.h"

@interface ReceiverAddressViewController ()

@property (nonatomic, strong) MAMapView *mapView;


@property (nonatomic, strong) NSMutableArray *routeIndicatorInfoArray;

@property (nonatomic, strong) AMapNaviDriveManager *driveManager;// 导航管理对象

@property (nonatomic, strong) ReceiverAddressInfoView *receiverInfoView;

@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;

@end

@implementation ReceiverAddressViewController


#pragma mark -----lazyloading-----

- (NSMutableArray *)routeIndicatorInfoArray {
    if (!_routeIndicatorInfoArray) {
        self.routeIndicatorInfoArray = [NSMutableArray array];
    }
    return _routeIndicatorInfoArray;
}


#pragma mark -----网络请求-----

- (void)requestData {
//    //147859731967
//    //147937270420
//    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&order_no=%@&pid=%@",@"pdaorderinfo", @"pda", _orderNumber, [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
//    NSDictionary *dic = @{@"api":@"pdaorderinfo", @"core":@"pda", @"order_no":_orderNumber, @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
//    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
//    
//    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.requestSerializer = [AFHTTPRequestSerializer serializer];
//    session.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
//    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        //        NSLog(@"dict = %@",dict);
//        //        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        if (0 == [dict[@"status"] floatValue]) {
//            NSDictionary *dataDic = dict[@"data"][@"order"][0];
//            OrderInfoModel *orderInfoModel = [[OrderInfoModel alloc] init];
//            [orderInfoModel setValuesForKeysWithDictionary:dataDic];
//            [orderInfoModel.addressInfo setValuesForKeysWithDictionary:dataDic[@"address"]];
//            for (NSDictionary *storedic in dataDic[@"store"]) {
//                StoreInfoModel *storemodel = [[StoreInfoModel alloc] init];
//                [storemodel setValuesForKeysWithDictionary:storedic];
//                for (NSDictionary *food in dataDic[@"store"][0][@"food"]) {
//                    FoodModel *foodModel = [[FoodModel alloc] init];
//                    [foodModel setValuesForKeysWithDictionary:food];
//                    [storemodel.foodArray addObject:foodModel];
//                }
//                [orderInfoModel.storeInfoArray addObject:storemodel];
//            }
//            
//            _addressInfoModel = orderInfoModel.addressInfo;
//            
//            // 回到主线程刷新UI
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self createView];
//            });
//            
//            
//        }
//        //        NSLog(@"2333");
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error is %@",error);
//    }];
}


#pragma mark -----视图方法-----

- (void)createView {
    _receiverInfoView = [[ReceiverAddressInfoView alloc] initWithReceiverName:_addressInfoModel.name tel:_addressInfoModel.mobile distance:@"-" address:[NSString stringWithFormat:@"%@%@",_addressInfoModel.address, _addressInfoModel.detail_addr] latitude:self.latitude longitude:self.longitude];
    [self.view addSubview:_receiverInfoView];
    [_receiverInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        //        make.height.equalTo(@120);// 临时高度  高度不用设置 已在自定义初始化方法中添加了高度的约束
    }];
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight - _receiverInfoView.selfheight)];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    // 把地图中心点设为路径规划的起点
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.latitude.floatValue, self.longitude.floatValue)];
    
    
    //路径规划
    _driveManager = [[AMapNaviDriveManager alloc] init];
    [self.driveManager setDelegate:self];
    
    AMapNaviPoint *startPoint =[AMapNaviPoint locationWithLatitude:self.latitude.floatValue longitude:self.longitude.floatValue];
    AMapNaviPoint *endPoint =[AMapNaviPoint locationWithLatitude:self.addressInfoModel.latitudeG.floatValue longitude:self.addressInfoModel.longitudeG.floatValue];
    
    
    [self.driveManager calculateDriveRouteWithStartPoints:@[startPoint] endPoints:@[endPoint] wayPoints:nil drivingStrategy:AMapNaviDrivingStrategySingleAvoidCongestion];
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
    self.navigationItem.title = @"收货地址";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    self.latitude = [[TcCourierInfoManager shareInstance] getLatitude];
    self.longitude = [[TcCourierInfoManager shareInstance] getLongitude];
    
    [self createView];
    
    
    
}


#pragma mark -----按钮方法-----

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AMapNaviManagerDelegate

// 路径规划成功
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager {
    NSLog(@"路径规划成功");
    self.receiverInfoView.disL.text = [NSString stringWithFormat:@"收货人距离:%ld米",driveManager.naviRoute.routeLength];
    [self addAnnotationWithStartPoint:driveManager.naviRoute.routeStartPoint endPoint:driveManager.naviRoute.routeEndPoint];
    [self showNaviRoutes];
    
    
}

// 路径规划失败
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error {
    NSLog(@"error is %@",error);
    NSLog(@"路径规划失败");
}

#pragma mark -----显示路径规划路径-----

// 添加大头针
- (void)addAnnotationWithStartPoint:(AMapNaviPoint *)start endPoint:(AMapNaviPoint *)end {
    // 终点大头针
    MAPointAnnotation *endPointAnnotation = [[MAPointAnnotation alloc] init];
    endPointAnnotation.coordinate = CLLocationCoordinate2DMake(end.latitude, end.longitude);
    endPointAnnotation.title = @"终点";
    [_mapView addAnnotation:endPointAnnotation];
    
    // 起点大头针
    MAPointAnnotation *startPointAnnotation = [[MAPointAnnotation alloc] init];
    startPointAnnotation.coordinate = CLLocationCoordinate2DMake(start.latitude, start.longitude);
    startPointAnnotation.title = @"起点";
    //    startPointAnnotation.
    [_mapView addAnnotation:startPointAnnotation];
}

- (void)showNaviRoutes {
    if ([self.driveManager.naviRoutes count] <= 0) {
        return;
    }
    
    [_mapView removeOverlays:_mapView.overlays];
    [self.routeIndicatorInfoArray removeAllObjects];
    
    for (NSNumber *aRouteID in [self.driveManager.naviRoutes allKeys]) {
        AMapNaviRoute *aRoute = [[self.driveManager naviRoutes] objectForKey:aRouteID];
        int count = (int)[[aRoute routeCoordinates] count];
        
        //添加路径Polyline
        CLLocationCoordinate2D *coords = (CLLocationCoordinate2D *)malloc(count * sizeof(CLLocationCoordinate2D));
        for (NSInteger i = 0; i < count; i++)
        {
            AMapNaviPoint *coordinate = [[aRoute routeCoordinates] objectAtIndex:i];
            coords[i].latitude = [coordinate latitude];
            coords[i].longitude = [coordinate longitude];
        }
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:count];
        
        SelectableOverlay *selectablePolyline = [[SelectableOverlay alloc] initWithOverlay:polyline];
        [selectablePolyline setRouteID:[aRouteID integerValue]];
        
        [_mapView addOverlay:selectablePolyline];
        free(coords);
        
        
        [self.routeIndicatorInfoArray addObject:aRouteID];
    }
    
    [_mapView showAnnotations:_mapView.annotations animated:NO];
    
    [self selectNaviRouteWithID:[[self.routeIndicatorInfoArray firstObject] integerValue]];
}

//  选择路径
- (void)selectNaviRouteWithID:(NSInteger)routeID {
    if ([self.driveManager selectNaviRouteWithRouteID:routeID])  {
        [self selecteOverlayWithRouteID:routeID];
    }
    else {
        NSLog(@"路径选择失败!");
    }
}

//  选择
- (void)selecteOverlayWithRouteID:(NSInteger)routeID {
    [_mapView.overlays enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<MAOverlay> overlay, NSUInteger idx, BOOL *stop) {
        if ([overlay isKindOfClass:[SelectableOverlay class]])  {
            SelectableOverlay *selectableOverlay = overlay;
            
            /* 获取overlay对应的renderer. */
            MAPolylineRenderer * overlayRenderer = (MAPolylineRenderer *)[_mapView rendererForOverlay:selectableOverlay];
            
            if (selectableOverlay.routeID == routeID) {
                /* 设置选中状态. */
                selectableOverlay.selected = YES;
                
                /* 修改renderer选中颜色. */
                overlayRenderer.fillColor   = selectableOverlay.selectedColor;
                overlayRenderer.strokeColor = selectableOverlay.selectedColor;
                
                /* 修改overlay覆盖的顺序. */
                [_mapView exchangeOverlayAtIndex:idx withOverlayAtIndex:_mapView.overlays.count - 1];
            } else {
                /* 设置选中状态. */
                selectableOverlay.selected = NO;
                
                /* 修改renderer选中颜色. */
                overlayRenderer.fillColor   = selectableOverlay.regularColor;
                overlayRenderer.strokeColor = selectableOverlay.regularColor;
            }
            
            [overlayRenderer glRender];
        }
    }];
    
}

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[SelectableOverlay class]]) {
        SelectableOverlay * selectableOverlay = (SelectableOverlay *)overlay;
        id<MAOverlay> actualOverlay = selectableOverlay.overlay;
        
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:actualOverlay];
        
        polylineRenderer.lineWidth = 8.f;
        polylineRenderer.strokeColor = selectableOverlay.isSelected ? selectableOverlay.selectedColor : selectableOverlay.regularColor;
        
        return polylineRenderer;
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        if ([[annotation title] isEqualToString:@"起点"]) {
            //            annotationView.pinColor = MAPinAnnotationColorRed;
            annotationView.image = [UIImage imageNamed:@"start"];
        } else {
            //            annotationView.pinColor = MAPinAnnotationColorGreen;
            annotationView.image = [UIImage imageNamed:@"end"];
        }
        annotationView.centerOffset = CGPointMake(0, -11);
        return annotationView;
    }
    return nil;
}


- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if ([view.annotation isKindOfClass:[MAPointAnnotation class]]) {
        //配置导航参数
        AMapNaviConfig * config = [[AMapNaviConfig alloc] init];
        config.destination = view.annotation.coordinate;//终点坐标，Annotation的坐标
        config.appScheme = [self getApplicationScheme];//返回的Scheme，需手动设置
        config.appName = [self getApplicationName];//应用名称，需手动设置
        config.strategy = AMapDrivingStrategyShortest;
        //若未调起高德地图App,引导用户获取最新版本的
        //        if(![MANavigation openAMapNavigation:config])
        //        {
        //            [MANavigation getLatestAMapApp];
        //        }
    }
}

- (NSString *)getApplicationName {
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo valueForKey:@"CFBundleDisplayName"];
}

- (NSString *)getApplicationScheme {
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes) {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier]) {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    return scheme;
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
