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
@interface LWCloudRegisterViewController ()<UITextFieldDelegate>
{
NSString *previousTextFieldContent;
UITextRange *previousSelection;
}
@property (nonatomic, strong) UIButton *countryBtn;
@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *codeText;
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
        make.left.mas_equalTo(self.countryBtn.mas_right).offset(10);
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
        make.left.mas_equalTo(self.countryBtn.mas_right).offset(20);
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
        make.width.mas_equalTo(100);
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
        make.left.mas_equalTo(userNameLabel.mas_right).offset(100);
        make.top.bottom.right.mas_equalTo(containerView2);
    }];
    
    //添加容器视图3
    UIView *containerView3 = [[UIView alloc] init];
    [self.view addSubview:containerView3];
    [containerView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(line3);
        make.bottom.mas_equalTo(line4);
    }];
    
    
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
