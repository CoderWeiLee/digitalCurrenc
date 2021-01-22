//
//  LoginViewController.m
//  digitalCurrency
//
//  Created by sunliang on 2019/1/29.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "LoginNetManager.h"
#import "YLTabBarController.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "AsyncTaskButton.h"
#import "CustomButton.h"
#import <objc/runtime.h>
#import <GT3Captcha/GT3Captcha.h>
#import <WebKit/WebKit.h>

@interface LoginViewController ()<AsyncTaskCaptchaButtonDelegate,CaptchaButtonDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDistance;

@property (nonatomic,copy) NSString *dbPath;//存入数据库的路径
@property (nonatomic,assign) NSInteger sqliteFlag;//判断是否存入
@property (weak, nonatomic) IBOutlet CustomButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *nowRegisterBtn;
@property (weak, nonatomic) IBOutlet UILabel *noAccountlabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomspec;
@property (weak, nonatomic) IBOutlet UILabel *phonelabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordlabel;
@property (weak, nonatomic) IBOutlet UIButton *eyebutton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title=LocalizationKey(@"login");
    self.view.backgroundColor = mainColor;
    self.userNameTF.placeholder = LocalizationKey(@"emailOrMobile");
    self.passwordTF.placeholder = LocalizationKey(@"inputPwd");
    [self setNavigationControllerStyle];
    [self leftbutitem];
    self.bottomspec.constant = SafeAreaBottomHeight + 10;
    //通过KVC修改占位文字的颜色
    Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *userNmaePlaceholderLabel = object_getIvar(_userNameTF, ivar);
    userNmaePlaceholderLabel.textColor = AppTextColor_Level_2;
    userNmaePlaceholderLabel.font = [UIFont boldSystemFontOfSize:12];
    
    UILabel *passwordPlaceholderLabel = object_getIvar(_passwordTF, ivar);
    passwordPlaceholderLabel.textColor = AppTextColor_Level_2;
    passwordPlaceholderLabel.font = [UIFont boldSystemFontOfSize:12];
    
    self.bottomDistance.constant=kWindowH == 812.0 ? 34 : 10;
    self.phonelabel.text = LocalizationKey(@"phoneNum");
    self.passwordlabel.text = LocalizationKey(@"pwd");
    self.noAccountlabel.text = LocalizationKey(@"noAccount");

    // Do any additional setup after loading the view from its nib.
    self.sqliteFlag = NO;
    [self.loginBtn setTitle:LocalizationKey(@"login") forState:UIControlStateNormal];
    [self.forgetPwdBtn setTitle:LocalizationKey(@"forgetPassword") forState:UIControlStateNormal];
    [self.nowRegisterBtn setTitle:LocalizationKey(@"nowregister") forState:UIControlStateNormal];
    
    
    [self.loginBtn setOriginaStyle];
    self.loginBtn.delegate = self;
}

//是否显示密码
- (IBAction)openeyeaction:(id)sender {
    self.eyebutton.selected = !self.eyebutton.selected;
    self.passwordTF.secureTextEntry = !self.eyebutton.selected;
}

-(void)leftbutitem{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 44);
    [btn setTitle:LocalizationKey(@"cancel") forState:UIControlStateNormal];
    [btn setTitleColor:AppTextColor_Level_1 forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(RighttouchEvent) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem*item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setNavigationControllerStyle];
}

-(void)RighttouchEvent{
    if (self.pushOrPresent) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self cancelNavigationControllerStyle];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)touchEvent:(UIButton *)sender {
    switch (sender.tag) {
        case 0://登录
            //[self ToLogin];
            break;
        case 1://忘记密码
            [self.navigationController pushViewController:[[ForgetViewController alloc]initWithNibName:@"ForgetViewController" bundle:nil] animated:YES];

            break;
        case 2://注册
            [self.navigationController pushViewController:[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil] animated:YES];
            break;

        default:
            break;
    }
}

//MARK:--存入数据库
-(void)saveToSqliteData{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [doc stringByAppendingPathComponent:@"user.sqlite"];
    self.dbPath = path;
    [self createTable];
}
// 建表
- (void)createTable {
    //NSLog(@"%s", __func__);

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
        FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            NSString *sql = @"CREATE TABLE 'User' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'name' VARCHAR(30), 'password' VARCHAR(30))";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"error when creating db table");
            } else {
//                NSLog(@"success to creating db table");
                [self insertData];
            }
            [db close];
        } else {
            NSLog(@"error when open db");
        }
    }else{
        [self queryData];
    }
}
// 查询数据
- (void)queryData {
   // NSLog(@"%s", __func__);

    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = @"select *from user";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
           // int userId = [rs intForColumn:@"id"];
            NSString *name = [rs stringForColumn:@"name"];
           // NSString *pass = [rs stringForColumn:@"password"];
            //NSLog(@"user id = %d, name = %@, pass = %@", userId, name, pass);
            if ([name isEqualToString:self.userNameTF.text]) {
                self.sqliteFlag = YES;
            }
        }
        if (self.sqliteFlag == NO) {
            [self insertData];
        }
        [db close];
    }
}
// 插入数据
- (void)insertData {
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {

        NSString *sql = @"insert into user (name, password) values(?, ?) ";
        NSString *name = self.userNameTF.text;
        NSString *password = self.passwordTF.text;
        BOOL res = [db executeUpdate:sql, name, password];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
//            NSLog(@"success to insert data");
        }
        [db close];
    }
}
#pragma mark - CaptchaButtonDelegate

- (BOOL)captchaButtonShouldBeginTapAction:(CustomButton *)button {
    if ([NSString stringIsNull:self.userNameTF.text]) {
        [self.view makeToast:LocalizationKey(@"inputMobileEmail") duration:1.5 position:CSToastPositionCenter];
        return NO;
    }
    if ([NSString stringIsNull:self.passwordTF.text]) {
        [self.view makeToast:LocalizationKey(@"inputLoginPassword") duration:1.5 position:CSToastPositionCenter];
        return NO;
    }else{
        return YES;
    }
}

//-(void)success:(NSDictionary *)result{
#pragma mark-二次验证返回数据
- (void)delegateGtCaptcha:(GT3CaptchaManager *)manager didReceiveCaptchaCode:(NSString *)code result:(NSDictionary *)result message:(NSString *)message{
    
    
    [EasyShowLodingView showLodingText:LocalizationKey(@"loading")];
    __block NSMutableString *postResult = [[NSMutableString alloc] init];
    [result enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        [postResult appendFormat:@"%@=%@&",key,obj];
    }];
    [postResult appendFormat:@"%@", [NSString stringWithFormat:@"username=%@&password=%@",self.userNameTF.text,self.passwordTF.text]];
    NSDictionary *headerFields = @{@"Content-Type":@"application/x-www-form-urlencoded;charset=UTF-8"};
    NSMutableURLRequest *secondaryRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",HOST,@"uc/login"]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
    secondaryRequest.HTTPMethod = @"POST";
    secondaryRequest.allHTTPHeaderFields = headerFields;
    NSString*md5Str= [MD5 md5:[NSString stringWithFormat:@"%@%@%@",[keychianTool readUserUUID],self.userNameTF.text,self.passwordTF.text]];
    [secondaryRequest addValue: md5Str forHTTPHeaderField:@"access-auth-token"];
    secondaryRequest.HTTPBody = [postResult dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:secondaryRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        //[manager closeGTViewIfIsOpen];
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        //NSLog(@"请求头中%@",httpResponse.allHeaderFields);
        if (!error && httpResponse.statusCode == 200) {
            NSError *err;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
            if (!err) {
                if ([dict[@"code"] integerValue] == 0) {
                    [YLUserInfo getuserInfoWithDic:dict[@"data"]];//存储登录信息
                    NSLog(@"登录信息-------------%@",dict);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [keychianTool saveToKeychainWithUserName:self.userNameTF.text withPassword:self.passwordTF.text];
                    });
                    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:[YLUserInfo shareUserInfo].ID, @"uid",nil];
                    [[ChatSocketManager share] ChatsendMsgWithLength:SOCKETREQUEST_LENGTH withsequenceId:0 withcmd:SUBSCRIBE_GROUP_CHAT withVersion:COMMANDS_VERSION withRequestId: 0 withbody:dic];//订阅聊天
                    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];//获取项目名称
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:[YLUserInfo shareUserInfo].token forKey:executableFile];
                    [defaults synchronize];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (self.enterType==1) {
                            YLTabBarController *SectionTabbar = [[YLTabBarController alloc] init];
                            APPLICATION.window.rootViewController = SectionTabbar;
                        }else{
                            if (self.pushOrPresent) {
                                [self.navigationController popViewControllerAnimated:YES];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"xinlogin" object:nil];
                            }else{
                                [self dismissViewControllerAnimated:YES completion:nil];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"xinlogin" object:nil];
                            }
                        }
                    });
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [APPLICATION.window makeToast:dict[@"message"] duration:1.5 position:CSToastPositionCenter];
                    });
                }
            }
        }
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
