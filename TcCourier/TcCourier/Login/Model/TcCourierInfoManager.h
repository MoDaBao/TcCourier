//
//  TcCourierInfoManager.h
//  TcCourier
//
//  Created by 莫大宝 on 16/11/9.
//  Copyright © 2016年 dabao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TcCourierInfoManager : NSObject

+ (TcCourierInfoManager *)shareInstance;

//  添加跑腿信息
- (void)setTcCourierInfoWithDic:(NSDictionary *)dic;
//  移除所有跑腿信息
- (void)removeAllTcCourierInfo;

//  保存跑腿登录手机号码
- (void)saveTcCourierPhone:(NSString *)phone;
//  获取跑腿登录手机号码
- (NSString *)getCourierPhone;
//  删除跑腿登录手机号码
- (void)deleteTcCourierPhone;


//  保存跑腿id
- (void)saveTcCourierUserId:(NSString *)userId;
//  获取跑腿id
- (NSString *)getTcCourierUserId;
//  删除跑腿id
- (void)deleteTcCourierUserId;


//  保存跑腿昵称
- (void)saveTcCourierUserName:(NSString *)userName;
//  获取跑腿昵称
- (NSString *)getTcCourierUserName;
//  删除跑腿昵称
- (void)deleteTcCourierUserName;


//  保存跑腿在线状态
- (void)saveTcCourierOnlineStatus:(NSString *)is_online;
//  获取跑腿在线状态
- (NSString *)getTcCourierOnlineStatus;
//  删除跑腿在线状态
- (void)deleteTcCourierOnlineStatus;


// 保存跑腿头像
- (void)saveTcCourierImg:(NSString *)img;
// 获取跑腿头像
- (NSString *)getTcCourierImg;
// 删除跑腿头像
- (void)deleteTcCourierImg;

// 保存区域id
- (void)saveAddressID:(NSString *)addressId;
// 获取区域id
- (NSString *)getAddressID;
// 删除区域id
- (void)deleteAddressID;


// 保存正在配送数量
- (void)saveSendingNumber:(NSString *)sendingNumber;
// 获取正在配送数量
- (NSString *)getSendingNumber;
// 删除正在配送数量
- (void)deleteSendingNumber;


// 保存评价分数
- (void)saveScore:(NSString *)score;
// 获取评价分数
- (NSString *)getScore;
// 删除评价分数
- (void)deleteScore;


@end
