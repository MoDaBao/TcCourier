//
//  TodayInfoItemVIew.m
//  peisongduan
//
//  Created by 莫大宝 on 16/6/24.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TodayInfoItemVIew.h"

@interface TodayInfoItemView ()

@property (nonatomic, copy) NSString *pd;

@end

@implementation TodayInfoItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title value:(NSString *)value {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor orangeColor];
        CGFloat centerY = frame.size.height * .5;
        UIFont *font = [UIFont systemFontOfSize:16];
        CGFloat height = [UILabel getHeightWithTitle:title font:font] + 6;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, centerY - height, frame.size.width, height)];
        titleLabel.numberOfLines = 2;
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = font;
//        titleLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:titleLabel];
        
        
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, centerY, frame.size.width, height)];
        valueLabel.font = font;
//        self.valueLabel.backgroundColor = [UIColor redColor];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        if ([title isEqualToString:@"今日有效单"]) {
            valueLabel.text = [NSString stringWithFormat:@"%@单",value];
        } else {
            valueLabel.text = [NSString stringWithFormat:@"￥%@元",value];
        }
        valueLabel.textColor = [UIColor colorWithRed:205 / 255.0 green:36 / 255.0 blue:29 / 255.0 alpha:1.0];
        [self addSubview:valueLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = self.bounds;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)click {
    _pd = [NSString stringWithFormat:@"%ld",self.tag - 4000];
    NSString *str = [NSString stringWithFormat:@"api=%@&core=%@&pd=%@&pid=%@",@"pdastatisticalinfo", @"pda", _pd, [[TcCourierInfoManager shareInstance] getTcCourierUserId]];
    NSDictionary *dic = @{@"api":@"pdastatisticalinfo", @"core":@"pda", @"pd":_pd, @"pid":[[TcCourierInfoManager shareInstance] getTcCourierUserId]};
    NSDictionary *pdic = @{@"data":dic, @"sign":[[MyMD5 md5:str] uppercaseString]};
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"text/javascript",@"application/json",@"text/json",nil]];
    [session POST:REQUEST_URL parameters:pdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (0 == [dict[@"status"] floatValue]) {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is %@",error);
    }];
    
}

@end
