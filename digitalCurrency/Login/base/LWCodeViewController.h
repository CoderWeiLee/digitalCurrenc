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
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, assign) FromType fromType;
@end

NS_ASSUME_NONNULL_END
