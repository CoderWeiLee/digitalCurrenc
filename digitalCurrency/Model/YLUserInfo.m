
//
//  YLUserInfo.m
//  BaseProject
//
//  Created by YLCai on 16/11/30.
//  Copyright © 2016年 YLCai. All rights reserved.
//

#import "YLUserInfo.h"

static YLUserInfo *userInfo = nil;

@implementation YLUserInfo

/*  通过初始化userIfo并保存在本地(单利模式)   */
+(instancetype)getuserInfoWithDic:(NSDictionary *)dic{
    userInfo = [[YLUserInfo alloc] initWithDictionary:dic];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USERINFO];
    [[NSUserDefaults standardUserDefaults] synchronize];//及时存储数据
    return userInfo;
}

-(id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self mj_setKeyValues:dic];
    }
    return self;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id",
             }; 
}
/*  获取用户已登陆的信息 */
+(instancetype)shareUserInfo{
    
    if (userInfo == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
        if (data) {
            userInfo =[NSKeyedUnarchiver unarchiveObjectWithData:data];
            return userInfo;
        }
    }
    return userInfo;
}

/*  判断用户是否登陆 */
+(BOOL)isLogIn{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
    if (data) {
        userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (![NSString stringIsNull:userInfo.username]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

/*  退出登陆 */
+(instancetype)logout{
//    userInfo = nil;
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERINFO];
    return userInfo;
}

/*  保存当前userInfo */
+(void)saveUser:(YLUserInfo *)userInfo{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USERINFO];
    [[NSUserDefaults standardUserDefaults] synchronize];//及时存储数据
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.levelName forKey:@"levelName"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.loginCount forKey:@"loginCount"];
    [aCoder encodeObject:self.secondLevel forKey:@"secondLevel"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.thirdLevel forKey:@"thirdLevel"];
    [aCoder encodeObject:self.inviter forKey:@"inviter"];
    [aCoder encodeObject:self.memberLevel forKey:@"memberLevel"];
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.promotionCode forKey:@"promotionCode"];
    [aCoder encodeObject:self.promotionPrefix forKey:@"promotionPrefix"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeBool:self.signInActivity forKey:@"signInActivity"];
    [aCoder encodeObject:self.memberRate forKey:@"memberRate"];
    [aCoder encodeObject:self.superPartner forKey:@"superPartner"];
    [aCoder encodeBool:self.signInAbility forKey:@"signInAbility"];
    [aCoder encodeObject:self.firstLevel forKey:@"firstLevel"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.levelName = [aDecoder decodeObjectForKey:@"levelName"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.loginCount = [aDecoder decodeObjectForKey:@"loginCount"];
        self.secondLevel = [aDecoder decodeObjectForKey:@"secondLevel"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.thirdLevel = [aDecoder decodeObjectForKey:@"thirdLevel"];
        self.inviter = [aDecoder decodeObjectForKey:@"inviter"];
        self.memberLevel = [aDecoder decodeObjectForKey:@"memberLevel"];
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.promotionCode = [aDecoder decodeObjectForKey:@"promotionCode"];
        self.promotionPrefix = [aDecoder decodeObjectForKey:@"promotionPrefix"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.signInActivity = [aDecoder decodeObjectForKey:@"signInActivity"];
        self.memberRate = [aDecoder decodeObjectForKey:@"memberRate"];
        self.superPartner = [aDecoder decodeObjectForKey:@"superPartner"];
        self.signInAbility = [aDecoder decodeObjectForKey:@"signInAbility"];
        self.firstLevel = [aDecoder decodeObjectForKey:@"firstLevel"];
    }
    return self;
}

@end
