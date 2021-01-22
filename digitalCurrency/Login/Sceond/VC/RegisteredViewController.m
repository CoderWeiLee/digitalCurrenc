//
//  RegisteredViewController.m
//  FlowerFire
//
//  Created by 王涛 on 2020/5/14.
//  Copyright © 2020 Celery. All rights reserved.
//。注册页面

#import "RegisteredViewController.h"
#import "RegisteredTableViewCell.h"
#import "SettingUpdateSubmitButton.h"
#import "FFSaveMnemonicViewController.h"
#import "FFRegisteredParamsModel.h"
#import "LoginNetManager.h"

@interface RegisteredViewController ()
{
    NSString *_username;
    NSString *_code;

    SettingUpdateSubmitButton *_nextButton;
    
}

@property(nonatomic,strong) NSArray *dataArray;
@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self initData];
    
}


/// 下一步
-(void)submitClick{
    
    if ([self checkIsHaveNumAndLetter:_username] != 3) {
        
        [self.view makeToast:LocalizationKey(@"578Tip44") duration:1.5 position:CSToastPositionCenter];

        return;
    }
    
    
   
    [LoginNetManager getMnemonicForUsername:_username code:_code completeHandle:^(id resPonseObj, int code) {
               if(code == 1){
                   
                   
                   
                    if ([resPonseObj[@"code"] integerValue] == 0) {
                        
                        NSString *mnemonic = resPonseObj[@"data"];
                      
                            FFRegisteredParamsModel *model = [FFRegisteredParamsModel new];
                            model.username = self->_username;
                            model.password = @"";
                            model.mnemonic = mnemonic;
                            model.promotion = self->_code;
                            FFSaveMnemonicViewController *r = [FFSaveMnemonicViewController new];
                            r.registeredParamsModel = model;
                            [self.navigationController pushViewController:r animated:YES];

                    }

                   
            
        }
        
    }];

}

-(int)checkIsHaveNumAndLetter:(NSString*)password{

    //数字条件

    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]"options:NSRegularExpressionCaseInsensitive error:nil];

    

    //符合数字条件的有几个字节

    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password

                                                                       options:NSMatchingReportProgress

                                                                         range:NSMakeRange(0, password.length)];

    

    //英文字条件

    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]"options:NSRegularExpressionCaseInsensitive error:nil];

    

    //符合英文字条件的有几个字节

    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)] ;

    if (tNumMatchCount == password.length) {

        //全部符合数字，表示沒有英文

        return 1;

    } else if (tLetterMatchCount == password.length) {

        //全部符合英文，表示沒有数字

        return 2;

    } else if (tNumMatchCount + tLetterMatchCount == password.length) {

        //符合英文和符合数字条件的相加等于密码长度

        return 3;

    } else {

        return 4;

        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误

    }

    

}



- (void)dataNormal:(NSDictionary *)dict type:(NSString *)type{
    if([type isEqualToString:@"1"]){
    }
}


- (void)createUI{
    
    UIView *bacView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/4)];
    self.view.backgroundColor = [UIColor blackColor];
    bacView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bacView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(60, ScreenHeight / 7+80 - Height_NavBar, ScreenWidth - 2 * 40, 80)];
    title.text = LocalizationKey(@"registeredTip7");
    title.font = [UIFont boldSystemFontOfSize:25];
    title.textColor = [UIColor whiteColor];
//    title.theme_textColor = THEME_TEXT_COLOR;
    title.numberOfLines = 2;
    [bacView addSubview:title];
     
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    _nextButton = [[SettingUpdateSubmitButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [_nextButton.submitButton setTitle:LocalizationKey(@"registeredTip4") forState:UIControlStateNormal];
    bottomView.backgroundColor = [UIColor blackColor];
//    _nextButton.backgroundColor = [UIColor orangeColor]
    [bottomView addSubview:_nextButton];
    
    UIButton *privacyAgreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:privacyAgreementButton];
    privacyAgreementButton.frame = CGRectMake(_nextButton.submitButton.ly_x + 20, _nextButton.ly_maxY + 10, ScreenWidth - 40 * 2 - 20 * 2, 30);
    [privacyAgreementButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
     
    NSString *leftStr = LocalizationKey(@"registeredTip5");
    NSString *rightStr = LocalizationKey(@"registeredTip8");
    NSString *titleStr = [NSString stringWithFormat:@"%@%@",leftStr,rightStr];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [attr addAttributes:@{NSForegroundColorAttributeName:MainColor} range:NSMakeRange(leftStr.length, rightStr.length)];
//    [attr addAttributes:@{SDThemeForegroundColorAt÷tributeName:[UIColor redColor]} range:NSMakeRange(0,leftStr.length)];
    [privacyAgreementButton setAttributedTitle:attr forState:UIControlStateNormal];
    privacyAgreementButton.hidden = YES;
    
    UIButton *jumpLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:jumpLoginButton];
    jumpLoginButton.frame = CGRectMake(0, ScreenHeight - SafeIS_IPHONE_X - 20, ScreenWidth, 30);
    [jumpLoginButton.titleLabel setFont:tFont(12)];
     
    leftStr = LocalizationKey(@"registeredTip9");
    rightStr = LocalizationKey(@"registeredTip10");
    titleStr = [NSString stringWithFormat:@"%@%@",leftStr,rightStr];
    attr = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [attr addAttributes:@{NSForegroundColorAttributeName:MainColor} range:NSMakeRange(leftStr.length, rightStr.length)];
//    [attr addAttributes:@{SDThemeForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0,leftStr.length)];
    [jumpLoginButton setAttributedTitle:attr forState:UIControlStateNormal];
    jumpLoginButton.hidden = YES;
    
    self.tableView.tableHeaderView = bacView;
    self.tableView.tableFooterView = bottomView;
    self.tableView.bounces = NO;
    self.tableView.frame = CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight-Height_NavBar);
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    
    [self.view bringSubviewToFront:jumpLoginButton];

    
    [_nextButton.submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *backButton = [[UIButton alloc] init];
    backButton.frame = CGRectMake(20, 40, 22, 22);
    [backButton setImage:[UIImage imageNamed:@"back3"] forState:UIControlStateNormal];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back_bbbb"] forState:UIControlStateNormal];
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    backButton.backgroundColor = [UIColor redColor];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:backButton];
    
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



- (void)initData{
//    inputinvite
    self.dataArray = @[@{@"details":@"registeredTip1"},@{@"details":@"inputinvite"}].copy;
}

#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    [self.tableView registerClass:[RegisteredTableViewCell class] forCellReuseIdentifier:identifier];
    RegisteredTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blackColor];
    [cell setCellData:self.dataArray[indexPath.row]];
    cell.textField.loginInputView.tag = indexPath.row;
    [cell.textField.loginInputView addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    cell.textField.tag = indexPath.row;
    cell.textField.loginInputView.secureTextEntry = NO;
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71;
}
 
- (void)textFieldWithText:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            _username = textField.text;
            break;
        case 1:
            _code = textField.text;
            break;
        default:
            break;
    }
    if(_username.length && _code.length){
        _nextButton.submitButton.enabled = YES;
    }else{
//        _nextButton.submitButton.enabled
        _nextButton.submitButton.enabled = NO;
    }
    
}



@end
