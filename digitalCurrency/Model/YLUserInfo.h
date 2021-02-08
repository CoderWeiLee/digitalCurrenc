//
//  YLUserInfo.h
//  BaseProject
//
//  Created by YLCai on 16/11/30.
//  Copyright © 2016年 YLCai. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Location : NSObject<NSCoding>
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@end

@interface Country: NSObject<NSCoding>
@property (nonatomic, copy) NSString *areaCode;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *zhName;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *localCurrency;
@property (nonatomic, copy) NSString *enName;
@end
@interface YLUserInfo : NSObject<NSCoding>


@property(nonatomic,strong)NSString *levelName;
@property (nonatomic, strong) Location *location;
@property (nonatomic, copy) NSString *loginCount;
@property (nonatomic, copy) NSString *secondLevel;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *district;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *memberLevel;
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *avatar;//头像地址
@property(nonatomic,strong)NSString *promotionCode;
@property(nonatomic,strong)NSString *promotionPrefix;
@property(nonatomic,strong)NSString *ID;
/*  通过初始化userIfo并保存在本地(单利模式)   */
+(instancetype)getuserInfoWithDic:(NSDictionary *)dic;

/*  获取用户已登陆的信息 */
+(instancetype)shareUserInfo;

/*  判断用户时否登陆 */
+(BOOL)isLogIn;

/*  退出登陆 */
+(instancetype)logout;

/*  保存当前userInfo */
+(void)saveUser:(YLUserInfo *)userInfo;

@end
