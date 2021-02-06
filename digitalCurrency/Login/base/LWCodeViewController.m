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
@interface LWCodeViewController ()
@property (nonatomic, strong) CRBoxInputView *boxInputView;
//倒计时
@property (nonatomic, strong) UILabel *countDownLabel;
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
    NSString *phone1 = [self.phoneNumber substringToIndex:2];
    NSString *phone2 = [self.phoneNumber substringWithRange:NSMakeRange(2, 6)];
    NSString *phone3 = [self.phoneNumber substringFromIndex:6];
    NSMutableAttributedString *codeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ %@ %@",send, phone1, phone2, phone3]];
    [codeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, codeStr.length)];
    [codeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#848484"] range:NSMakeRange(0, 5)];
    [codeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(5, codeStr.length - 5)];
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
    self.boxInputView = [[CRBoxInputView alloc] initWithCodeLength:4];
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
    NSMutableAttributedString *countDownStr = [[NSMutableAttributedString alloc] initWithString:@"60秒后重新获取"];
    [countDownStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, countDownStr.length)];
    [countDownStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F88D02"] range:NSMakeRange(0, 3)];
    [countDownStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#848484"] range:NSMakeRange(3, countDownStr.length - 3)];
    self.countDownLabel.attributedText = countDownStr;
    [self.view addSubview:self.countDownLabel];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.boxInputView.mas_bottom).offset(45);
    }];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"#F88D02"];
    self.loginBtn.layer.cornerRadius = 2;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.countDownLabel.mas_bottom).offset(44);
    }];
    
}

#pragma mark - 返回上个界面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 登录
- (void)loginAction {
    
}


@end
