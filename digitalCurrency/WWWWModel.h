//
//  WWWWModel.h
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWWWModel : NSObject

/// 已获得ATO
@property (nonatomic, copy) NSString *bonusMoney;

/// 动态奖励
@property (nonatomic, copy) NSString *dynamicMoney;

/// 等级名称
@property (nonatomic, copy) NSString *levelName;

/// 静态奖励
@property (nonatomic, copy) NSString *staticMoney;

/// 小区业绩
@property (nonatomic, copy) NSString *littleMoney;

/// 小区人数
@property (nonatomic, copy) NSString *littleCount;

/// 剩余本金
@property (nonatomic, copy) NSString *lessBuy;

/// 团队总人数
@property (nonatomic, copy) NSString *teamCount;

/// 总交易量（ATO24小时交易量)
@property (nonatomic, copy) NSString *totalExchange;

/// 投入余量
@property (nonatomic, copy) NSString *myValue;

/// 总分红基数
@property (nonatomic, copy) NSString *myTotal;

/// 当日投入（今日总质押量
@property (nonatomic, copy) NSString *todayExchange;

/// 已销毁量
@property (nonatomic, copy) NSString *actDestory;

/// ATO已经释放
@property (nonatomic, copy) NSString *unLockMoney;

/// ATO锁定中
@property (nonatomic, copy) NSString *lockMoney;

/// 还可获得ATO
@property (nonatomic, copy) NSString *lessBonusMoney;

/// 当日产出（今日总产出量-
@property (nonatomic, copy) NSString *todayBonus;

/// ACT总量
@property (nonatomic, copy) NSString *actTotal;

@end

NS_ASSUME_NONNULL_END
