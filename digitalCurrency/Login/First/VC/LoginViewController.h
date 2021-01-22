//
//  LoginViewController.h
//  FlowerFire
//
//  Created by 王涛 on 2020/4/30.
//  Copyright © 2020 Celery. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomspec;

@property (weak, nonatomic) UIButton *eyebutton;

@property (weak, nonatomic) UIButton *forgetPwdBtn;
@property (weak, nonatomic) UIButton *loginBtn;

@end

NS_ASSUME_NONNULL_END
