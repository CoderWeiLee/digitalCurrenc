//
//  LWCodeViewController.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/6.
//  

#import "LWCodeViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
#import <CRBoxInputView/CRBoxInputView.h>
#import "BaseNetManager.h"
#import "MBProgressHUD.h"
@interface LWCodeViewController ()
@property (nonatomic, strong) CRBoxInputView *boxInputView;
//倒计时
@property (nonatomic, strong) UILabel *countDownLabel;
@property (nonatomic, strong) UIButton *countDownBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation LWCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = LocalizationKey(@"578Tip178");
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.equalTo(self.view).offset(Height_StatusBar + 14.5);
    }];
   
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftItem setImage:[UIImage imageNamed:@"back_bbbb"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftItem];
    [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.centerY.mas_equalTo(titleLabel);
    }];
    
    UILabel *phoneTitleLabel = [[UILabel alloc] init];
    phoneTitleLabel.text = LocalizationKey(@"enterCode");
    phoneTitleLabel.font = [UIFont systemFontOfSize:27];
    phoneTitleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:phoneTitleLabel];
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(53);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *sendLabel = [[UILabel alloc] init];
    NSString *send = LocalizationKey(@"codeSended");
    NSString *phone1 = [self.phoneNumber substringToIndex:3];
    NSString *phone2 = [self.phoneNumber substringWithRange:NSMakeRange(3, 4)];
    NSString *phone3 = [self.phoneNumber substringFromIndex:7];
    NSMutableAttributedString *codeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ %@ %@",send, phone1, phone2, phone3]];
    [codeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, codeStr.length)];
    [codeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#848484"] range:NSMakeRange(0, 7)];
    [codeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(7, codeStr.length - 7)];
    sendLabel.attributedText = codeStr;
    [self.view addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneTitleLabel.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.view);
    }];
    
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.showLine = YES; //必需
    //背景颜色
    cellProperty.cellBgColorNormal = [UIColor clearColor];
    cellProperty.cellBgColorSelected = [UIColor clearColor];
    //边框颜色
    cellProperty.cellBorderColorNormal = [UIColor clearColor];
    cellProperty.cellBorderColorSelected = [UIColor clearColor];
    //光标颜色
    cellProperty.cellCursorColor = [UIColor colorWithHexString:@"#F88D02"];
    //光标宽度
    cellProperty.cellCursorWidth = 2;
    //光标高度
    cellProperty.cellCursorHeight = 40;
    //字体颜色
    cellProperty.cellTextColor = [UIColor whiteColor];
    //字体大小
    cellProperty.cellFont = [UIFont systemFontOfSize:40];
    cellProperty.customLineViewBlock = ^CRLineView * _Nonnull{
        CRLineView *lineView = [CRLineView new];
        lineView.underlineColorNormal = [UIColor colorWithHexString:@"#1E1E1E"];
        lineView.underlineColorSelected = [UIColor colorWithHexString:@"#1E1E1E"];
        lineView.underlineColorFilled = [UIColor colorWithHexString:@"#1E1E1E"];
        [lineView.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.bottom.offset(0);
            make.width.mas_equalTo(55);
        }];
        return lineView;
    }; //可选
    self.boxInputView = [[CRBoxInputView alloc] initWithCodeLength:6];
    /*
     typeof(self) __weak wSelf = self;
     if (self.block) {
         typeof(self) __strong sSelf = wSelf;
     */
    typeof(self) __weak weakSelf = self;
    self.boxInputView.textDidChangeblock = ^(NSString * _Nullable text, BOOL isFinished) {
        if (isFinished) {
            //自动点击登录按钮
            typeof(self) __strong strongSelf = weakSelf;
            //判断当前的type类型
            if (strongSelf.fromType == FromTypeLogin) {
                [strongSelf loginActionWithPhone:strongSelf.phoneNumber code:text];
            }else {
                //推荐码0QAP
                NSString *phoneNumber = [strongSelf.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
                [strongSelf registerActionWithPhone:phoneNumber userName:strongSelf.userName country:strongSelf.countryName code:text promotion:strongSelf.promotion];
            }
        }
    };
    self.boxInputView.customCellProperty = cellProperty;
    [self.boxInputView loadAndPrepareViewWithBeginEdit:YES];
    [self.view addSubview:self.boxInputView];
    [self.boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(55);
        make.right.mas_equalTo(self.view).offset(-55);
        make.top.mas_equalTo(sendLabel.mas_bottom).offset(105);
        make.height.mas_equalTo(54);
    }];
    
    self.countDownLabel = [[UILabel alloc] init];
    NSMutableAttributedString *countDownStr = [[NSMutableAttributedString alloc] initWithString:@"获取验证码"];
    [countDownStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, countDownStr.length)];
    [countDownStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F88D02"] range:NSMakeRange(0, countDownStr.length)];
    self.countDownLabel.attributedText = countDownStr;
    [self.view addSubview:self.countDownLabel];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.boxInputView.mas_bottom).offset(45);
    }];
    
    self.countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.countDownBtn addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.countDownBtn];
    [self.countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.countDownLabel);
    }];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"#F88D02"];
    self.loginBtn.layer.cornerRadius = 2;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn addTarget:self action:@selector(loginActionWithPhone:code:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.countDownLabel.mas_bottom).offset(44);
    }];
    
    //第一次进入直接调用发送验证码的方法
    [self sendCode];
}

#pragma mark - 返回上个界面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 登录
- (void)loginActionWithPhone:(NSString *)phone code:(NSString *)code {
    //验证码登录
    NSDictionary *params = @{@"phone": phone, @"code": code};
    [BaseNetManager requestWithPost:@"http://12345.abc.tm/uc/login/phone" parameters:params successBlock:^(NSDictionary *resultObject, int isSuccessed) {
        if ([resultObject[@"code"] isEqualToString:@"200"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = @"登录成功";
            hud.mode = MBProgressHUDModeText;
            [hud showAnimated:YES];
            [hud hideAnimated:YES afterDelay:1.0];
        }else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = resultObject[@"message"];
            hud.mode = MBProgressHUDModeText;
            [hud showAnimated:YES];
            [hud hideAnimated:YES afterDelay:1.0];
        }
    }];
}

#pragma mark - 注册

/// 注册的接口
/// @param phone 手机号码
/// @param userName 用户名
/// @param country 国家，需要传递中文
/// @param code 验证码
/// @param promotion 推荐码
- (void)registerActionWithPhone:(NSString *)phone userName:(NSString *)userName country:(NSString *)country code:(NSString *)code promotion:(NSString *)promotion {
    //注册
    NSDictionary *params = @{@"phone": phone, @"username": userName, @"country": country, @"code": code, @"promotion": promotion};
    [BaseNetManager requestWithPost:@"http://12345.abc.tm/uc/register/phone" parameters:params successBlock:^(NSDictionary *resultObject, int isSuccessed) {
        if ([resultObject[@"code"] isEqualToString:@"200"]) {
            
        }else {
            
        }
    }];
}

#pragma mark - 发送验证码
- (void)sendCode {
    //准备发送验证码
    if (self.fromType == FromTypeLogin) {
        /*
         uc/mobile/login 登录接口
         1、验证码接口

          URL:/uc/mobile/code
         参数：phone
         country 注意是中文，比如 “美国"

    

         3、手机验证码登陆
         URL:/uc/login/phone

         参数：phone
         code
         */
        NSDictionary *params = @{@"phone": @"13770801786", @"country": @"中国"};
        typeof(self) __weak weakSelf = self;
        [BaseNetManager requestWithPost:@"http://12345.abc.tm/uc/mobile/login" parameters:params successBlock:^(NSDictionary *resultObject, int isSuccessed) {
            typeof(weakSelf) __strong strongSelf = weakSelf;
            if (isSuccessed) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = @"短信已发送";
                hud.mode = MBProgressHUDModeText;
                [hud showAnimated:YES];
                [hud hideAnimated:YES afterDelay:1.0];
                strongSelf.countDownBtn.userInteractionEnabled = NO;
                //按钮倒计时
                [strongSelf messageTime];
            }else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = resultObject[@"message"];
                hud.mode = MBProgressHUDModeText;
                [hud showAnimated:YES];
                [hud hideAnimated:YES afterDelay:1.0];
                strongSelf.countDownBtn.userInteractionEnabled = YES;
            }
        }];
    }else {
        /*
         URL:/uc/register/phone
         参数：phone
         username
         country
         code
         promotion
         */
        NSDictionary *params = @{@"phone": @"13770801786", @"country": @"中国"};
        typeof(self) __weak weakSelf = self;
        [BaseNetManager requestWithPost:@"http://12345.abc.tm/uc/mobile/code" parameters:params successBlock:^(NSDictionary *resultObject, int isSuccessed) {
            typeof(weakSelf) __strong strongSelf = weakSelf;
            if (isSuccessed) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = @"短信已发送";
                hud.mode = MBProgressHUDModeText;
                [hud showAnimated:YES];
                [hud hideAnimated:YES afterDelay:1.0];
                strongSelf.countDownBtn.userInteractionEnabled = NO;
                //按钮倒计时
                [strongSelf messageTime];
            }else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = resultObject[@"message"];
                hud.mode = MBProgressHUDModeText;
                [hud showAnimated:YES];
                [hud hideAnimated:YES afterDelay:1.0];
                strongSelf.countDownBtn.userInteractionEnabled = YES;
            }
        }];
    }
}

#pragma mark - 按钮的倒计时
- (void)messageTime {   __block int timeout=60; //倒计时时间
   dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
   dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
   
   dispatch_source_set_event_handler(_timer, ^{
       if(timeout<=0){ //倒计时结束，关闭
           dispatch_source_cancel(_timer);
           dispatch_async(dispatch_get_main_queue(), ^{
               NSMutableAttributedString *countDownStr = [[NSMutableAttributedString alloc] initWithString:@"重新发送验证码"];
               [countDownStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, countDownStr.length)];
               [countDownStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F88D02"] range:NSMakeRange(0, countDownStr.length)];
               self.countDownLabel.attributedText = countDownStr;
               self.countDownBtn.userInteractionEnabled = YES;
           });
       }else{
           int seconds = timeout % 61;
           NSString *strTime = [NSString stringWithFormat:@"%02d", seconds];
           dispatch_async(dispatch_get_main_queue(), ^{
               NSMutableAttributedString *countDownStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@秒后重新获取",strTime]];
               [countDownStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, countDownStr.length)];
               [countDownStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F88D02"] range:NSMakeRange(0, 3)];
               [countDownStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#848484"] range:NSMakeRange(3, countDownStr.length - 3)];
               self.countDownLabel.attributedText = countDownStr;
               self.countDownBtn.userInteractionEnabled = NO;
           });
           timeout--;
       }
   });
   dispatch_resume(_timer);
   
}
@end
