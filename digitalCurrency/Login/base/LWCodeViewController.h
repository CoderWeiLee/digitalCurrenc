//
//  LWCodeViewController.h
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/6.
//  验证码界面

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, FromType) {
    FromTypeLogin,  //从登录页面跳转过来的
    FromTypeRegister,  //从注册页面跳转过来的
};
@interface LWCodeViewController : BaseViewController
//国家名称，需要传递中文
@property (nonatomic, copy) NSString *countryName;
//电话号码
@property (nonatomic, copy) NSString *phoneNumber;
//用户名
@property (nonatomic, copy) NSString *userName;
//用户填写的推荐码
@property (nonatomic, copy) NSString *promotion;
@property (nonatomic, assign) FromType fromType;
@end

NS_ASSUME_NONNULL_END
