//
//  LWCloudLoginViewController.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/4.
//

#import "LWCloudLoginViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
#import "LWCodeViewController.h"
#import "LWSelectAreaViewController.h"
#import "MBProgressHUD.h"
#import "LWCloudRegisterViewController.h"
@interface LWCloudLoginViewController ()
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UILabel *countryCodeLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *switchBtn;
@property (nonatomic, strong) UILabel *protocolLabel;
@property (nonatomic, strong) UIButton *protocolBtn;
@property (nonatomic, strong) UIButton *selectAreaBtn;
@end

@implementation LWCloudLoginViewController

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
    phoneTitleLabel.text = LocalizationKey(@"578Tip179");
    phoneTitleLabel.font = [UIFont systemFontOfSize:27];
    phoneTitleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:phoneTitleLabel];
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(53);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *areaTitleLabel = [[UILabel alloc] init];
    areaTitleLabel.text = LocalizationKey(@"578Tip180");
    areaTitleLabel.font = [UIFont systemFontOfSize:15];
    areaTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
    [self.view addSubview:areaTitleLabel];
    [areaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneTitleLabel.mas_bottom).offset(15.5);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.top.mas_equalTo(areaTitleLabel.mas_bottom).offset(32);
    }];
    
    self.countryLabel = [[UILabel alloc] init];
    self.countryLabel.text = LocalizationKey(@"china");
    self.countryLabel.font = [UIFont systemFontOfSize:17];
    self.countryLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.countryLabel];
    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1).offset(7.5);
        make.top.mas_equalTo(line1.mas_bottom).offset(18.5);
    }];
    
    UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    [self.view addSubview:rightArrow];
    [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(line1).offset(-1);
        make.centerY.mas_equalTo(self.countryLabel);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.top.mas_equalTo(self.countryLabel.mas_bottom).offset(17.5);
    }];
    
    //添加选择地区的按钮
    self.selectAreaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectAreaBtn addTarget:self action:@selector(selectAreaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectAreaBtn];
    [self.selectAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(line1);
        make.bottom.mas_equalTo(line2);
    }];
    
    self.countryCodeLabel = [[UILabel alloc] init];
    self.countryCodeLabel.text = @"+ 86";
    self.countryCodeLabel.textColor = [UIColor colorWithHexString:@"#848484"];
    self.countryCodeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.countryCodeLabel];
    [self.countryCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line2).offset(7.5);
        make.top.mas_equalTo(line2.mas_bottom).offset(21.5);
    }];
    
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
    [self.view addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@55);
        make.left.mas_equalTo(self.view).offset(79.5);
        make.width.mas_equalTo(@1);
        make.top.mas_equalTo(line2.mas_bottom);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    UIView *leftView = [[UIView alloc]init];
    
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号"];
    [placeHolder addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:1 alpha:0.6] range:NSMakeRange(0, placeHolder.length)];
    [placeHolder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, placeHolder.length)];
    self.phoneTextField.attributedPlaceholder = placeHolder;
    self.phoneTextField.textColor = [UIColor whiteColor];
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verticalLine.mas_right);
        make.top.mas_equalTo(line2.mas_bottom);
        make.height.mas_equalTo(54);
        make.right.mas_equalTo(line2);
    }];
    [self.phoneTextField addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.phoneTextField);
        make.width.mas_equalTo(14);
    }];
    self.phoneTextField.leftView = leftView;
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom);
    }];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nextBtn.backgroundColor = [UIColor colorWithHexString:@"#F88D02"];
    self.nextBtn.layer.cornerRadius = 2;
    self.nextBtn.layer.masksToBounds = YES;
    [self.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(line3.mas_bottom).offset(40.5);
    }];
    
    self.switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchBtn setTitle:@"没有账号？去注册" forState:UIControlStateNormal];
    self.switchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.switchBtn setTitleColor:[UIColor colorWithHexString:@"#848484"] forState:UIControlStateNormal];
    [self.switchBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.switchBtn];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nextBtn.mas_bottom).offset(19.5);
        make.centerX.mas_equalTo(self.view);
    }];
    
    self.protocolLabel = [[UILabel alloc] init];
    NSMutableAttributedString *protocolStr = [[NSMutableAttributedString alloc] initWithString:@"登录即代表您同意 《用户注册协议》"];
    [protocolStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, protocolStr.length)];
    [protocolStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#848484"] range:NSMakeRange(0, 8)];
    [protocolStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F88D02"] range:NSMakeRange(8, protocolStr.length-8)];
    self.protocolLabel.attributedText = protocolStr;
    [self.view addSubview:self.protocolLabel];
    [self.protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-44);
    }];
    
    self.protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.protocolBtn addTarget:self action:@selector(protocolAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.protocolBtn];
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.protocolLabel);
    }];
}




#pragma mark - 返回上个界面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 下一步
- (void)nextAction {
    //检查手机号的格式是否正确
    if (![self valiMobile:self.phoneTextField.text]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请输入正确的手机号码";
        hud.mode = MBProgressHUDModeText;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:1.0];
        return;
    }
    //检测账号有没有注册过
    LWCodeViewController *codeVc = [[LWCodeViewController alloc] init];
    codeVc.phoneNumber = self.phoneTextField.text;
    codeVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:codeVc animated:YES];
}

#pragma mark - 切换注册
- (void)registerAction {
    LWCloudRegisterViewController *registerVc = [[LWCloudRegisterViewController alloc] init];
    registerVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerVc animated:YES];
}

#pragma mark - 用户协议的点击
- (void)protocolAction {
    
}

#pragma mark - 选择地区
- (void)selectAreaAction {
    LWSelectAreaViewController *selectVc = [[LWSelectAreaViewController alloc] init];
    selectVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectVc animated:YES];
}

#pragma mark - 检查手机号码格式
- (BOOL)valiMobile:(NSString *)mobile {
    if (mobile.length != 11) {
        return NO;
    }
    /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
         * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
         * 电信号段: 133,149,153,170,173,177,180,181,189
         */
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
        
        /**
         * 中国移动：China Mobile
         * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         */
        NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
        
        /**
         * 中国联通：China Unicom
         * 130,131,132,145,155,156,170,171,175,176,185,186
         */
        NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
        
        /**
         * 中国电信：China Telecom
         * 133,149,153,170,173,177,180,181,189
         */
        NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        
        if (([regextestmobile evaluateWithObject:mobile] == YES) ||
            ([regextestcm evaluateWithObject:mobile] == YES) ||
            ([regextestct evaluateWithObject:mobile] == YES) ||
            ([regextestcu evaluateWithObject:mobile] == YES)) {
            return YES;
        }else {
            return NO;
        }
}
@end
