//
//  MainTabBarController.m
//  模仿简书自定义Tabbar（纯代码）
//
//  Created by 余钦 on 16/6/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTabBar.h"
#import "MainNavigationController.h"
#import "AppDelegate.h"


@interface MainTabBarController ()<MainTabBarDelegate>
@property(nonatomic, weak)MainTabBar *mainTabBar;


@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetupMainTabBar];
    [self SetupAllControllers];
    
}




#pragma mark -----自定义tabBarController方法-----
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

        for (UIView *child in self.tabBar.subviews) {
            if ([child isKindOfClass:[UIControl class]]) {
                [child removeFromSuperview];
            }
        }

}


- (void)SetupMainTabBar {
    MainTabBar *mainTabBar = [[MainTabBar alloc] init];
    mainTabBar.frame = self.tabBar.bounds;
    mainTabBar.delegate = self;
    [self.tabBar addSubview:mainTabBar];
    _mainTabBar = mainTabBar;
}

- (void)SetupAllControllers {
    
    NSArray *titles = @[@"首页", @"个人中心"];
    NSArray *images = @[@"shouyehuise", @"person"];
    NSArray *selectedImages = @[@"chicken", @"gerenzhongxinchengse"];
    

    HomePageViewController *homeVC = [[HomePageViewController alloc] init];
    self.homeVc = homeVC;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.addressDelegate = homeVC;
    
    PersonCenterViewController *personVC = [[PersonCenterViewController alloc]init];
    self.personVC = personVC;    
    
    NSArray *viewControllers = @[homeVC, personVC];
    
    for (NSInteger i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName {
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}



#pragma mark -----------------· ---mainTabBar delegate
- (void)tabBar:(MainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag {
    self.selectedIndex = toBtnTag;
}

//- (void)tabBarClickWriteButton:(MainTabBar *)tabBar {
////    WriteViewController *writeVc = [[WriteViewController alloc] init];
////    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:writeVc];
////    
////    [self presentViewController:nav animated:YES completion:nil];
//}
@end
