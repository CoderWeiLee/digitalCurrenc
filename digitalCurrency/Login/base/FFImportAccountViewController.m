//
//  FFImportAccountViewController.m
//  FlowerFire
//
//  Created by 王涛 on 2020/8/24.
//  Copyright © 2020 Celery. All rights reserved.
//  导入账户

#import "FFImportAccountViewController.h"
#import "LoginNetManager.h"
#import "YLTabBarController.h"
//#import "WTMainRootViewController.h"

@interface FFImportAccountViewController ()

@property(nonatomic, strong)UIViewController                   *currentVC;
@property(nonatomic, strong)FFImportAccountChildViewController *mnemonicVC;
@property(nonatomic, strong)FFImportAccountChildViewController *privateKeyVC;
@property(nonatomic, strong)UISegmentedControl                 *segment;

@end

@implementation FFImportAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBar];
    [self createUI];
    [self initChildVC];
}

- (void)createNavBar{
//    self.gk_navigationItem.title = LocalizationKey(@"578Tip32");
}

- (void)createUI{
    self.view.backgroundColor = [UIColor blackColor];
    self.segment.frame = CGRectMake(self.view.centerX - 100, Height_NavBar + 10, 200, 31);
    [self.view addSubview:self.segment];
    UIButton *backButton = [[UIButton alloc] init];
    backButton.frame = CGRectMake(20, 40, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"back_bbbb"] forState:UIControlStateNormal];
//    backButton.backgroundColor = [UIColor redColor];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:backButton];
    
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}




-(void)initChildVC{
    [self addChildViewController:self.mnemonicVC];
    [self addChildViewController:self.privateKeyVC];
    [self.view addSubview:self.mnemonicVC.view];
    self.currentVC = self.mnemonicVC;
    
}

#pragma mark - action
-(void)segmentSwitch:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self replaceController:self.currentVC newController:self.mnemonicVC];
            break;
        case 1:
            [self replaceController:self.currentVC newController:self.privateKeyVC];
            break;
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.2 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        if(finished){
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        }else{
            self.currentVC = oldController;
        }
    }];
    
}
 
-(UISegmentedControl *)segment{
    if(!_segment){
        _segment = [[UISegmentedControl alloc] init];
      
        [_segment insertSegmentWithTitle:LocalizationKey(@"578Tip33") atIndex:0 animated:YES];
//        [_segment insertSegmentWithTitle:LocalizationKey(@"578Tip34") atIndex:1 animated:YES];
        _segment.selectedSegmentIndex = 0;
        [_segment setWidth:200 forSegmentAtIndex:0];
//        [_segment setWidth:100 forSegmentAtIndex:1];
        [_segment addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

- (FFImportAccountChildViewController *)mnemonicVC{
    if(!_mnemonicVC){
        _mnemonicVC = [[FFImportAccountChildViewController alloc] initWithFFImportAccountType:FFImportAccountTypeMnemonic];
        _mnemonicVC.view.frame = CGRectMake(0, self.segment.bottom + 20, ScreenWidth, ScreenHeight - Height_NavBar);
    }
    return _mnemonicVC;
}

- (FFImportAccountChildViewController *)privateKeyVC{
    if(!_privateKeyVC){
        _privateKeyVC = [[FFImportAccountChildViewController alloc] initWithFFImportAccountType:FFImportAccountTypePrivateKey];
        _privateKeyVC.view.frame = CGRectMake(0, self.segment.bottom + 20, ScreenWidth, ScreenHeight - Height_NavBar);
    }
    return _privateKeyVC;
}

@end
 
#import "LoginTextField.h"
#import "SettingUpdateSubmitButton.h"
#import "AESCipher.h"
#import "FFAcountManager.h"
#import "WTLabel.h"

@interface FFImportAccountChildViewController ()
{
    LoginTextField *_userName;
    WTLabel        *_tip;
    UITextView     *_content;
    SettingUpdateSubmitButton *_bottomView;
}
@property(nonatomic, assign)FFImportAccountType FFImportAccountType;
@end

@implementation FFImportAccountChildViewController

- (instancetype)initWithFFImportAccountType:(FFImportAccountType)FFImportAccountType{
    self = [super init];
    if(self){
        self.FFImportAccountType = FFImportAccountType;
    }
    return self;
}

#pragma mark action
-(void)submitClick{
    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:2];
    switch (self.FFImportAccountType) {
        case FFImportAccountTypeMnemonic:
        {
            md[@"username"] = _userName.loginInputView.text;
            md[@"mnemonic"] = aesEncryptString(_content.text, AES_KEY);
            
            [EasyShowLodingView showLodingText:LocalizationKey(@"loading")];

            [LoginNetManager importMnemonic:md completeHandle:^(id resPonseObj, int code) {
                [EasyShowLodingView hidenLoding];
                if ([resPonseObj[@"code"] integerValue] == 0) {
                    if (code == 1) {
                        
                        [self.view makeToast:LocalizationKey(@"FiatTip22") duration:1.5 position:CSToastPositionCenter];

                        [self loginSuc:resPonseObj];
                    }else{
                        
                        [self.view makeToast:resPonseObj[@"message"] duration:1.5 position:CSToastPositionCenter];

                    }

                    
                    
                }else{
                    [self.view makeToast:resPonseObj[@"message"] duration:1.5 position:CSToastPositionCenter];

                }

                
                
                
            }];
            
//            [self.afnetWork jsonPostDict:@"/api/user/importMnemonic" JsonDict:md Tag:@"1"];
        }
            break;
        default:
        {
            md[@"username"] = _userName.loginInputView.text;
            md[@"private_key"] = aesEncryptString(_content.text, AES_KEY);
//            [self.afnetWork jsonPostDict:@"/api/user/importPrivateKey" JsonDict:md Tag:@"2"];
        }
            break;
    }
}

//导入成功自动登录
- (void)dataNormal:(NSDictionary *)dict type:(NSString *)type{
//    [WTUserInfo getuserInfoWithDic:dict[@"data"][@"userinfo"]];
    
    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:4];
    md[@"username"] = _userName.loginInputView.text;
    md[@"type"] = @([type integerValue]); // type 0 密码登录 1 助记词 2 私钥
//    md[@"pwd"] = aesEncryptString(_content.text, AES_KEY);
    [[FFAcountManager sharedInstance] saveUserAccount:md]; 
     
//    [[NSNotificationCenter defaultCenter] postNotificationName:SWITCH_ACCOUNT_SUCCESS_NOTIFICATION object:nil userInfo:nil];
    
//    printAlert(dict[@"msg"], 1.f);
    //如果是登录页面导入的，那么跳转到首页
    BOOL isLogin = NO;
//    for (UIViewController *vc in self.navigationController.viewControllers) {
//        if([vc isKindOfClass:[LOGIN_VIEW_CONTROLLER class]]){
//            isLogin = YES;
//        }
//    }
//    if(isLogin){
//        WTMainRootViewController *view=[[WTMainRootViewController alloc]init];
//        UIWindow * window = [UIApplication sharedApplication].delegate.window;
//
//        [window.rootViewController dismissViewControllerAnimated:NO completion:^{
//            window.rootViewController = view;
//            [window makeKeyAndVisible];
//        }];
//    }else{
//        [self closeVC];
//    }
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self createNavBar];
    [self createUI];
//    [self initData];
}

- (void)createNavBar{
//    self.gk_navigationBar.hidden = YES;
}

- (void)createUI{
    self.view.backgroundColor = [UIColor blackColor];
    _userName = [[LoginTextField alloc] initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, 0 , ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 95) titleStr:LocalizationKey(@"578Tip35") placeholderStr:LocalizationKey(@"578Tip36")];
    _userName.title.textColor = [UIColor whiteColor];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:LocalizationKey(@"578Tip36") attributes:
        @{NSForegroundColorAttributeName:RGB(132, 132, 132)
             }];
    _userName.line.backgroundColor = RGB(30, 30, 30);

    
    _userName.loginInputView.attributedPlaceholder = attrString;
    _userName.loginInputView.textColor = [UIColor whiteColor];
    
    
    [self.view addSubview:_userName];
    _userName.loginInputView.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _tip = [[WTLabel alloc] initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, _userName.bottom + 25, ScreenWidth, 20)];
    _tip.font = tFont(16);
    _tip.textColor = [UIColor whiteColor];
//    _tip.theme_textColor = THEME_TEXT_COLOR;
    [self.view addSubview:_tip];
    
    _content = [[UITextView alloc] initWithFrame:CGRectMake(_tip.left, _tip.bottom + 10, ScreenWidth - 2 * _tip.left, 120)];
    _content.layer.cornerRadius = 5;
    _content.layer.borderWidth = 1;
    _content.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _content.backgroundColor = RGB(30, 30, 30);
    _content.textColor = [UIColor whiteColor];
    [self.view addSubview:_content];
    
    
    if(self.FFImportAccountType == FFImportAccountTypeMnemonic){
        _tip.text = LocalizationKey(@"578Tip37");
    }else{
        _tip.text = LocalizationKey(@"578Tip41");
    }
    
    _bottomView = [[SettingUpdateSubmitButton alloc] initWithFrame:CGRectMake(0, _content.bottom+20, ScreenWidth, 100)];
    [_bottomView.submitButton setTitle:LocalizationKey(@"578Tip39") forState:UIControlStateNormal];
    [_bottomView.submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    _bottomView.submitButton.frame = CGRectMake(OverAllLeft_OR_RightSpace,  50, ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 50);
    
    [self.view addSubview:_bottomView];
     
    //用户名和密码都输入了按钮可以点
//    RACSignal *signal = [RACSignal combineLatest:@[_userName.loginInputView.rac_textSignal, _content.rac_textSignal] reduce:^id _Nonnull(NSString *account , NSString *pwd){
//        return @(account.length && pwd.length);
//    }];
//
//    RAC(_bottomView.submitButton,enabled) = signal;
    
    
     
}

- (void)loginSuc:(NSDictionary *)dict{
        if ([dict[@"code"] integerValue] == 0) {
            [YLUserInfo getuserInfoWithDic:dict[@"data"]];//存储登录信息
            NSLog(@"登录信息-------------%@",dict);
//            dispatch_async(dispatch_get_main_queue(), ^{
                [keychianTool saveToKeychainWithUserName:_userName withPassword:@""];
//            });
            NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:[YLUserInfo shareUserInfo].ID, @"uid",nil];
            [[ChatSocketManager share] ChatsendMsgWithLength:SOCKETREQUEST_LENGTH withsequenceId:0 withcmd:SUBSCRIBE_GROUP_CHAT withVersion:COMMANDS_VERSION withRequestId: 0 withbody:dic];//订阅聊天
            NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];//获取项目名称
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[YLUserInfo shareUserInfo].token forKey:executableFile];
            [defaults synchronize];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (self.enterType==1) {
                    YLTabBarController *SectionTabbar = [[YLTabBarController alloc] init];
                    APPLICATION.window.rootViewController = SectionTabbar;
//                }else{
//                    if (self.pushOrPresent) {
//                        [self.navigationController popViewControllerAnimated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"xinlogin" object:nil];
//                    }else{
//                        [self dismissViewControllerAnimated:YES completion:nil];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:@"xinlogin" object:nil];
//                    }
//                }
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [APPLICATION.window makeToast:dict[@"message"] duration:1.5 position:CSToastPositionCenter];
            });
        }
    
}



@end
