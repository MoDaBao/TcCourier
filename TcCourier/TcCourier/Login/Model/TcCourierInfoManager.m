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

// phone
- (void)saveTcCourierPhone:(NSString *)phone {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getCourierPhone {
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    if (!phone) {
        return @" ";
    }
    return phone;
}
- (void)deleteTcCourierPhone {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// userid
- (void)saveTcCourierUserId:(NSString *)userId {
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getTcCourierUserId {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    if (!userid) {
        return @" ";
    }
    return userid;
}
- (void)deleteTcCourierUserId {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// username
- (void)saveTcCourierUserName:(NSString *)userName {
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getTcCourierUserName {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (!username) {
        return @" ";
    }
    return username;
}
- (void)deleteTcCourierUserName {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// is_online
- (void)saveTcCourierOnlineStatus:(NSString *)is_online {
    [[NSUserDefaults standardUserDefaults] setObject:is_online forKey:@"is_online"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getTcCourierOnlineStatus {
    NSString *is_online = [[NSUserDefaults standardUserDefaults] objectForKey:@"is_online"];
    if (!is_online) {
        return @" ";
    }
    return is_online;
}
- (void)deleteTcCourierOnlineStatus {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"is_online"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// address_id
- (void)saveAddressID:(NSString *)addressId {
    [[NSUserDefaults standardUserDefaults] setObject:addressId forKey:@"address_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getAddressID {
    NSString *address_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"address_id"];
    if (!address_id) {
        return @" ";
    }
    return address_id;
}
- (void)deleteAddressID {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"address_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// sending_number
- (void)saveSendingNumber:(NSString *)sendingNumber {
    [[NSUserDefaults standardUserDefaults] setObject:sendingNumber forKey:@"sending_number"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getSendingNumber {
    NSString *sending_number = [[NSUserDefaults standardUserDefaults] objectForKey:@"sending_number"];
    if (!sending_number) {
        return @" ";
    }
    return sending_number;
}
- (void)deleteSendingNumber {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sending_number"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// score
- (void)saveScore:(NSString *)score {
    [[NSUserDefaults standardUserDefaults] setObject:score forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getScore {
    NSString *score = [[NSUserDefaults standardUserDefaults] objectForKey:@"score"];
    if (!score) {
        return @" ";
    }
    return score;
}
- (void)deleteScore {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// img
- (void)saveTcCourierImg:(NSString *)img {
    [[NSUserDefaults standardUserDefaults] setObject:img forKey:@"img"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getTcCourierImg {
    NSString *img = [[NSUserDefaults standardUserDefaults] objectForKey:@"img"];
    if (!img) {
        return @" ";
    }
    return img;
}
- (void)deleteTcCourierImg {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"img"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveLatitude:(NSString *)latitude {
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getLatitude {
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"];
    if (!latitude) {
        return @" ";
    }
    return latitude;
}

- (void)saveLongitude:(NSString *)longitude {
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getLongitude {
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"];
    if (!longitude) {
        return @" ";
    }
    return longitude;
}

- (void)saveCourierAddress:(NSString *)courierAddress {
    [[NSUserDefaults standardUserDefaults] setObject:courierAddress forKey:@"courierAddress"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getCourierAddress {
    NSString *courierAddress = [[NSUserDefaults standardUserDefaults] objectForKey:@"courierAddress"];
    if (!courierAddress) {
        return @" ";
    }
    return courierAddress;
}

@end
