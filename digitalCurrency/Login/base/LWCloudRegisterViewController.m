//
//  LWCloudRegisterViewController.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/7.
//

#import "LWCloudRegisterViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
#import "LWButton.h"
#import <CRBoxInputView/CRBoxInputView.h>
#import "MBProgressHUD.h"
#import "LWCodeViewController.h"
@interface LWCloudRegisterViewController ()<UITextFieldDelegate>
{
NSString *previousTextFieldContent;
UITextRange *previousSelection;
}
@property (nonatomic, strong) UIButton *countryBtn;
@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *switchBtn;
@property (nonatomic, strong) UILabel *protocolLabel;
@property (nonatomic, strong) UIButton *protocolBtn;
@end

@implementation LWCloudRegisterViewController
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
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(line1);
        make.top.mas_equalTo(line1.mas_bottom).offset(54);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(line1);
        make.top.mas_equalTo(line2.mas_bottom).offset(54);
    }];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
    [self.view addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(line1);
        make.top.mas_equalTo(line3.mas_bottom).offset(54);
    }];
    
    //添加容器视图1
    UIView *containerView1 = [[UIView alloc] init];
    [self.view addSubview:containerView1];
    [containerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(line1);
        make.bottom.mas_equalTo(line2);
    }];
    
    //添加国家名称按钮
    self.countryBtn = [LWButton buttonWithType:UIButtonTypeCustom];
    
    [self.countryBtn setTitle:@"中国" forState:UIControlStateNormal];
    self.countryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.countryBtn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
    [containerView1 addSubview:self.countryBtn];
    [self.countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1).offset(5);
        make.centerY.mas_equalTo(containerView1);
    }];
    
    //添加垂直分割线
    UIView *verLine = [[UIView alloc] init];
    verLine.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
    [containerView1 addSubview:verLine];
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countryBtn.mas_right).offset(20);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(containerView1);
        make.width.mas_equalTo(1);
    }];
    
    self.phoneText = [[UITextField alloc] init];
    NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:@"--- ---- ----"];
    [placeHolder addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, placeHolder.length)];
    [placeHolder addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, placeHolder.length)];
    self.phoneText.attributedPlaceholder = placeHolder;
    self.phoneText.keyboardType = UIKeyboardTypePhonePad;
    self.phoneText.textColor = [UIColor whiteColor];
    self.phoneText.delegate = self;
    self.phoneText.font = [UIFont boldSystemFontOfSize:15];
    [self.phoneText addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [containerView1 addSubview:self.phoneText];
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countryBtn.mas_right).offset(40);
        make.top.bottom.mas_equalTo(containerView1);
    }];
  
    
    //添加容器视图2  2583542755
    UIView *containerView2 = [[UIView alloc] init];
    [self.view addSubview:containerView2];
    [containerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(line2);
        make.bottom.mas_equalTo(line3);
    }];
    
    //添加用户名
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.text = @"用户名";
    userNameLabel.textColor = [UIColor whiteColor];
    userNameLabel.font = [UIFont systemFontOfSize:15];
    [containerView2 addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1).offset(5);
        make.centerY.mas_equalTo(containerView2);
        make.width.mas_equalTo(82);
    }];
    
    //添加输入框
    self.nameText = [[UITextField alloc] init];
    NSMutableAttributedString *namePlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入用户名"];
    [namePlaceholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, namePlaceholder.length)];
    [namePlaceholder addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#848484"] range:NSMakeRange(0, namePlaceholder.length)];
    self.nameText.attributedPlaceholder = namePlaceholder;
    self.nameText.textColor = [UIColor whiteColor];
    self.nameText.font = [UIFont systemFontOfSize:15];
    [containerView2 addSubview:self.nameText];
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(userNameLabel.mas_right);
        make.top.bottom.right.mas_equalTo(containerView2);
    }];
    
    //添加容器视图3
    UIView *containerView3 = [[UIView alloc] init];
    [self.view addSubview:containerView3];
    [containerView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(line3);
        make.bottom.mas_equalTo(line4);
    }];
    
    //添加推荐码
    UILabel *recommendCodeLabel = [[UILabel alloc] init];
    recommendCodeLabel.text = @"推荐码";
    recommendCodeLabel.textColor = [UIColor whiteColor];
    recommendCodeLabel.font = [UIFont systemFontOfSize:15];
    [containerView3 addSubview:recommendCodeLabel];
    [recommendCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1).offset(5);
        make.centerY.mas_equalTo(containerView3);
        make.width.mas_equalTo(82);
    }];
    
    //添加推荐码输入框
    self.codeText = [[UITextField alloc] init];
    NSMutableAttributedString *codePlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入推荐码"];
    [codePlaceholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, codePlaceholder.length)];
    [codePlaceholder addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#848484"] range:NSMakeRange(0, codePlaceholder.length)];
    self.codeText.attributedPlaceholder = codePlaceholder;
    self.codeText.textColor = [UIColor whiteColor];
    self.codeText.font = [UIFont systemFontOfSize:15];
    [containerView3 addSubview:self.codeText];
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(recommendCodeLabel.mas_right);
        make.top.bottom.right.mas_equalTo(containerView3);
    }];
    
    //添加下一步按钮
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
        make.top.mas_equalTo(line4.mas_bottom).offset(40.5);
    }];
    
    //添加切换账号登录
    self.switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchBtn setTitle:@"切换账号登录" forState:UIControlStateNormal];
    self.switchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.switchBtn setTitleColor:[UIColor colorWithHexString:@"#848484"] forState:UIControlStateNormal];
    [self.switchBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.switchBtn];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nextBtn.mas_bottom).offset(19.5);
        make.centerX.mas_equalTo(self.view);
    }];
    
    self.protocolLabel = [[UILabel alloc] init];
    NSMutableAttributedString *protocolStr = [[NSMutableAttributedString alloc] initWithString:@"注册即代表您同意 《用户注册协议》"];
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

#pragma mark - 用户协议的点击
- (void)protocolAction {
    
}

#pragma mark - 切换账号登录
- (void)registerAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 下一步
- (void)nextAction {
    //检查手机号的格式是否正确
    if (![self valiMobile:[self.phoneText.text stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请输入正确的手机号码";
        hud.mode = MBProgressHUDModeText;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:1.0];
        return;
    }
    //检测账号有没有注册过
    LWCodeViewController *codeVc = [[LWCodeViewController alloc] init];
    codeVc.phoneNumber = self.phoneText.text;
    codeVc.fromType = FromTypeRegister;
    codeVc.countryName = self.countryBtn.titleLabel.text;
    codeVc.userName = self.nameText.text;
    codeVc.promotion = self.codeText.text;
    codeVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:codeVc animated:YES];
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


#pragma mark - 返回上个界面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - textFieldDidChange
- (void)textFieldEditingChanged:(UITextField *)textField
{
//限制手机账号长度（有两个空格）
if (textField.text.length > 13) {
textField.text = [textField.text substringToIndex:13];
}
NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
NSString *currentStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
NSString *preStr = [previousTextFieldContent stringByReplacingOccurrencesOfString:@" " withString:@""];
//正在执行删除操作时为0，否则为1
char editFlag = 0;
if (currentStr.length <= preStr.length) {
editFlag = 0;
}
else {
editFlag = 1;
}
NSMutableString *tempStr = [NSMutableString new];
int spaceCount = 0;
if (currentStr.length < 3 && currentStr.length > -1) {
spaceCount = 0;
}else if (currentStr.length < 7 && currentStr.length > 2) {
spaceCount = 1;
}else if (currentStr.length < 12 && currentStr.length > 6) {
spaceCount = 2;
}
for (int i = 0; i < spaceCount; i++) {
if (i == 0) {
[tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(0, 3)], @" "];
}else if (i == 1) {
[tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(3, 4)], @" "];
}else if (i == 2) {
[tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(7, 4)], @" "];
}
}
if (currentStr.length == 11) {
[tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(7, 4)], @" "];
}
if (currentStr.length < 4) {
[tempStr appendString:[currentStr substringWithRange:NSMakeRange(currentStr.length - currentStr.length % 3, currentStr.length % 3)]];
}else if(currentStr.length > 3 && currentStr.length <12) {
NSString *str = [currentStr substringFromIndex:3];
[tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
if (currentStr.length == 11) {
[tempStr deleteCharactersInRange:NSMakeRange(13, 1)];
}
}
textField.text = tempStr;
// 当前光标的偏移位置
NSUInteger curTargetCursorPosition = targetCursorPosition;
if (editFlag == 0) {
//删除
if (targetCursorPosition == 9 || targetCursorPosition == 4) {
curTargetCursorPosition = targetCursorPosition - 1;
}
}else {
//添加
if (currentStr.length == 8 || currentStr.length == 4) {
curTargetCursorPosition = targetCursorPosition + 1;
}
}
UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument] offset:curTargetCursorPosition];
[textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition :targetPosition]];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
previousTextFieldContent = textField.text;
previousSelection = textField.selectedTextRange;
return YES;
}
@end
