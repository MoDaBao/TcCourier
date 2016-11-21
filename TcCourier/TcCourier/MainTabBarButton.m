//
//  MainTabBarButton.m
//  cmbfaeApp
//
//  Created by 余钦 on 16/6/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "MainTabBarButton.h"


//image ratio
#define TabBarImageRatio 0.4
#define TabBarTitleRation .5

@interface MainTabBarButton ()


@end


@implementation MainTabBarButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //只需要设置一次的放置在这里
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = kFont14;
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];

        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    }
    return self;
}


//重写该方法可以去除长按按钮时出现的高亮效果
- (void)setHighlighted:(BOOL)highlighted {
    
}

// 修改self.imageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * TabBarImageRatio;
    
    return CGRectMake(0, 6, imageW, imageH);
}

// 修改self.titleLabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * TabBarTitleRation;
    
    return CGRectMake(0, contentRect.size.height * TabBarImageRatio + 6, titleW, titleH);
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    _tabBarItem = tabBarItem;
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.selectedImage forState:UIControlStateSelected];
}

@end
