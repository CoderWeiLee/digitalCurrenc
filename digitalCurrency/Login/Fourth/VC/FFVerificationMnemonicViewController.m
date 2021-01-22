//
//  FFVerificationMnemonicViewController.m
//  FlowerFire
//
//  Created by 王涛 on 2020/8/25.
//  Copyright © 2020 Celery. All rights reserved.
//  验证助记词

#import "FFVerificationMnemonicViewController.h"
#import "FFVerificationMnemonicCell.h"
#import "AESCipher.h"
#import "FFVerifyEmailViewController.h"
#import "FFAcountManager.h"
#import "HelpManager.h"
#import "UIControl+YYAdd.h"
#import <UIControl+RACSignalSupport.h>
#import "LoginNetManager.h"
#import "YLTabBarController.h"
#import "YLUserInfo.h"

#define KEY_UUID_DATA [UIApplication sharedApplication].appBundleID
#define KEY_UUID_TEXT @"UUID_TEXT"

@interface FFVerificationMnemonicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    WTLabel *_tip;
    
}
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionView *bottomCollectionView;
@property(nonatomic, strong)NSString         *mnemonicStr;
@property(nonatomic, strong)NSString         *promotion;
@property(nonatomic, strong)NSMutableArray   *selectedArray;
@property(nonatomic, strong)NSMutableArray   *selectedIndexArray;


@end

@implementation FFVerificationMnemonicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    [self createNavBar];
    [self initData];
    [self createUI];
    
}

- (void)createNavBar{
//    self.gk_navigationItem.title = LocalizationKey(@"578Tip105");
}

- (void)createUI{
    _tip = [[WTLabel alloc]  initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, Height_NavBar + 10, ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 30) Text:LocalizationKey(@"578Tip106") Font:tFont(15)  textColor:KBlackColor parentView:self.view];
    _tip.numberOfLines = 2;
    _tip.textColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor blackColor];
     
    UICollectionViewFlowLayout *ufl = [[UICollectionViewFlowLayout alloc] init];
    ufl.minimumLineSpacing = 0;
    ufl.minimumInteritemSpacing = 0;
    ufl.itemSize = CGSizeMake((ScreenWidth - 2 * OverAllLeft_OR_RightSpace)/3, 45);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, _tip.bottom + 20, ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 45 * self.dataArray.count/3 + 12.5) collectionViewLayout:ufl];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = RGB(30, 30, 30);
    self.collectionView.layer.cornerRadius = 5;
    [self.view  addSubview:self.collectionView];
     
    UICollectionViewFlowLayout *ufl2 = [[UICollectionViewFlowLayout alloc] init];
    ufl2.minimumLineSpacing = 0;
    ufl2.minimumInteritemSpacing = 0;
    ufl2.itemSize = CGSizeMake((ScreenWidth - 2 * OverAllLeft_OR_RightSpace)/3, 45);
    
    self.bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, self.collectionView.bottom + 30, ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 45 * self.dataArray.count/3 + 5) collectionViewLayout:ufl2];
    self.bottomCollectionView.delegate = self;
    self.bottomCollectionView.dataSource = self;
    self.bottomCollectionView.backgroundColor = RGB(30, 30, 30);
    self.bottomCollectionView.layer.cornerRadius = 5;
    [self.view  addSubview:self.bottomCollectionView];
    
    WTButton *nextButton = [[WTButton alloc] initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, self.bottomCollectionView.bottom + 30, ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 45) titleStr:LocalizationKey(@"578Tip104") titleFont:tFont(15) titleColor:KWhiteColor parentView:self.view];
    nextButton.layer.cornerRadius = 2;
    nextButton.backgroundColor = [UIColor orangeColor];
    
//    @weakify(self)
    [nextButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//        @strongify(self)
        if(self.selectedArray.count == 12){
            self.mnemonicStr = [self.selectedArray componentsJoinedByString:@" "];

            NSLog(@"self.mnemonicStr:%@",self.mnemonicStr);
            if([HelpManager isBlankString:self.mnemonicStr]){
//                printAlert(LocalizationKey(@"578Tip107"), 1.f);
            }else{//加密后验证
                self.mnemonicStr = aesEncryptString(self.mnemonicStr, AES_KEY);
                NSLog(@"self.mnemonicStr:%@",self.mnemonicStr);

                NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:2];
                md[@"username"] = self.registeredParamsModel.username;
                md[@"mnemonic"] = self.mnemonicStr;
//                [self.afnetWork jsonPostDict:@"/api/user/validationMnemonic" JsonDict:md Tag:@"1"];
                [EasyShowLodingView showLodingText:LocalizationKey(@"loading")];

                [LoginNetManager validationMnemonic:md completeHandle:^(id resPonseObj, int code) {
                    [EasyShowLodingView hidenLoding];
                    if ([resPonseObj[@"code"] integerValue] == 0) {
                        if (code == 1) {
                            
                            [self dataNormal:resPonseObj type:1];
                        }else{
                            
                            [self.view makeToast:resPonseObj[@"message"] duration:1.5 position:CSToastPositionCenter];

                        }

                        
                        
                    }else{
                        [self.view makeToast:resPonseObj[@"message"] duration:1.5 position:CSToastPositionCenter];

                    }

                    
               
                    
                }];
                
                
                
            }
        }else{
//            printAlert(LocalizationKey(@"578Tip107"), 1.f);
            [self.view makeToast:LocalizationKey(@"578Tip107") duration:1.5 position:CSToastPositionCenter];

        }
    }];
    
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

     

- (NSString *)removeSpaceAndNewline:(NSString *)str

{

NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];

return text;

}





- (void)dataNormal:(NSDictionary *)dict type:(NSInteger)type{
    switch (type) {
        case 1:
        {   
            NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:5];
            md[@"username"] = self.registeredParamsModel.username;
            md[@"mnemonic"] = self.mnemonicStr;
            md[@"promotion"] = self.registeredParamsModel.promotion;
            //
            [LoginNetManager registerMnemonic:md completeHandle:^(id resPonseObj, int code) {
                
                if ([resPonseObj[@"code"] integerValue] == 0) {
                    if (code == 1) {
                        
                        [self dataNormal:resPonseObj type:2];
                    }else{
                        
                        [self.view makeToast:resPonseObj[@"message"] duration:1.5 position:CSToastPositionCenter];

                    }

                    
                    
                }else{
                    [self.view makeToast:resPonseObj[@"message"] duration:1.5 position:CSToastPositionCenter];

                }

                
                
            }];
            
            
//            [self.afnetWork jsonPostDict:@"/api/user/register" JsonDict:md Tag:@"2"];
            

            
            
            
            
            
        }
            break;
        case 2:
        {
//            printAlert(dict[@"msg"], 1.f);
//
//            [WTUserInfo getuserInfoWithDic:dict[@"data"][@"userinfo"]];
             
            NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:4];
            md[@"username"] = self.registeredParamsModel.username;
            md[@"type"] = @(1); // type 0 密码登录 1 助记词 2 私钥
            md[@"pwd"] = self.mnemonicStr;
            [[FFAcountManager sharedInstance] saveUserAccount:md];
            [self.view makeToast:LocalizationKey(@"Success_re") duration:1.5 position:CSToastPositionCenter];

            [self loginSuc:dict];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUCCESS_NOTIFICATION object:nil userInfo:nil];
//            [[NSNotificationCenter defaultCenter] postNotificationName:SWITCH_ACCOUNT_SUCCESS_NOTIFICATION object:nil userInfo:nil];
        }
            break;
        default:
            break;
    }
}

- (void)initData{
    self.selectedArray = [NSMutableArray array];
    self.selectedIndexArray = [NSMutableArray array];
    [self.collectionView reloadData];
    
}

//点X号删除选中
-(void)deleteSelectedClick:(UIButton *)btn{
    NSIndexPath *indexPath = [self getButtonConvertPoint:btn];
    [self.selectedArray removeObjectAtIndex:indexPath.item];
    [self.selectedIndexArray removeObjectAtIndex:indexPath.item];
       
    
    [self.collectionView reloadData];
    [self.bottomCollectionView reloadData];
}
 
#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.bottomCollectionView){
        if([self.selectedIndexArray containsObject:indexPath]){
            for (int i = 0; i<self.selectedArray.count; i++ ) {
                NSString *str = self.selectedArray[i];
                if([str isEqualToString:self.dataArray[indexPath.item]]){
                    [self.selectedArray removeObjectAtIndex:i];
                    [self.selectedIndexArray removeObject:indexPath];
                    
                    break;
                }
            }
        }else{
            [self.selectedArray addObject:self.dataArray[indexPath.item]];
            [self.selectedIndexArray addObject:indexPath];
        }
        
        [self.collectionView reloadData];
        [self.bottomCollectionView reloadData];
        
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.collectionView){
        static NSString *identifier = @"cell";
        [self.collectionView registerClass:[FFVerificationMnemonicCell class] forCellWithReuseIdentifier:identifier];
        FFVerificationMnemonicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if(self.selectedArray.count>0){
            cell.title.text = self.selectedArray[indexPath.row];
            CGFloat sigleWidth = [HelpManager getLabelWidth:15 labelTxt:cell.title.text].width + 20;
            cell.title.frame = CGRectMake((cell.width - sigleWidth)/2, 12.5, sigleWidth, 30);
            cell.title.backgroundColor = KWhiteColor;
            
            cell.deleteButton.frame = CGRectMake(cell.title.right - 7.5, cell.title.top - 7.5, 15, 15);
            [cell.deleteButton addTarget:self action:@selector(deleteSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else{
        static NSString *identifier = @"cell2";
        [self.bottomCollectionView registerClass:[FFVerificationMnemonicCell class] forCellWithReuseIdentifier:identifier];
        FFVerificationMnemonicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if(self.dataArray.count>0){
            cell.title.text = self.dataArray[indexPath.row];
            CGFloat sigleWidth = [HelpManager getLabelWidth:15 labelTxt:cell.title.text].width + 20;
            cell.title.frame = CGRectMake((cell.width - sigleWidth)/2, 12.5, sigleWidth, 30);
             
            if([self.selectedIndexArray containsObject:indexPath]){
                cell.title.backgroundColor = RGB(242, 243, 247);
                cell.title.textColor = KBlackColor;
            }else{
                cell.title.backgroundColor = [UIColor orangeColor];
                cell.title.textColor = KWhiteColor;
            }
            
        }
        
        return cell;
    }

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == self.collectionView){
        return self.selectedArray.count;
    }
    return self.dataArray.count;
}

#pragma mark - privateMethod
- (NSIndexPath *)getButtonConvertPoint:(UIButton * _Nonnull)btn {
    CGPoint point = btn.center;
    point = [self.collectionView convertPoint:point fromView:btn.superview];
    NSIndexPath  *indexpath = [self.collectionView indexPathForItemAtPoint:point];
    return indexpath;
}
 
- (NSString *)getUUID {
    NSString *UUIDString = @"";
//    NSDictionary *UUID_Dict = (NSDictionary *)[ToolUtil load:KEY_UUID_DATA];
//    if ([UUID_Dict.allKeys containsObject:KEY_UUID_TEXT]) {
//        UUIDString = UUID_Dict[KEY_UUID_TEXT];
//    }else {
        //没有就获取
//        UUIDString = [UIDevice currentDevice].identifierForVendor.UUIDString;
        //保存
//        [ToolUtil save:KEY_UUID_DATA data:@{KEY_UUID_TEXT:UUIDString}];
//    }
    NSLog(@"UUIDString:%@",UUIDString);
    return UUIDString;
}

//登录成功

- (void)loginSuc:(NSDictionary *)dict{
        if ([dict[@"code"] integerValue] == 0) {
            [YLUserInfo getuserInfoWithDic:dict[@"data"]];//存储登录信息
            NSLog(@"登录信息-------------%@",dict);
//            dispatch_async(dispatch_get_main_queue(), ^{
                [keychianTool saveToKeychainWithUserName:self.registeredParamsModel.username withPassword:@""];
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
//                        [[NSNotificationCenter defaultCenter] postNotificationName:@"xinlogin" object:nil];
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
