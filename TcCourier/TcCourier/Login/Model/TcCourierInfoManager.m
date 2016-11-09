//
//  TcCourierInfoManager.m
//  TcCourier
//
//  Created by 莫大宝 on 16/11/9.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import "TcCourierInfoManager.h"

@implementation TcCourierInfoManager

+ (TcCourierInfoManager *)shareInstance {
    static TcCourierInfoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TcCourierInfoManager alloc] init];
    });
    return manager;
}

- (void)setTcCourierInfoWithDic:(NSDictionary *)dic {
    [self saveTcCourierPhone:dic[@"phone"]];
    [self saveTcCourierUserId:dic[@"userid"]];
    [self saveTcCourierUserName:dic[@"username"]];
    [self saveTcCourierOnlineStatus:dic[@"is_online"]];
    [self saveAddressID:dic[@"address_id"]];
    [self saveSendingNumber:dic[@"sending_number"]];
    [self saveScore:dic[@"score"]];
    [self saveTcCourierImg:dic[@"img"]];
}

- (void)removeAllTcCourierInfo {
    [self deleteTcCourierPhone];
    [self deleteTcCourierUserId];
    [self deleteTcCourierUserName];
    [self deleteTcCourierOnlineStatus];
    [self deleteAddressID];
    [self deleteSendingNumber];
    [self deleteScore];
    [self deleteTcCourierImg];
}

- (void)saveTcCourierPhone:(NSString *)phone {
    
}

//- (NSString *)getCourierPhone {
//    
//}



@end
