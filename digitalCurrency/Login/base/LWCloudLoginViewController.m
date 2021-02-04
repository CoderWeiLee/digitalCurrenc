//
//  LWCloudLoginViewController.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/4.
//

#import "LWCloudLoginViewController.h"
#import <Masonry/Masonry.h>
@interface LWCloudLoginViewController ()

@end

@implementation LWCloudLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LocalizationKey(@"578Tip178");
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftItem setImage:[UIImage imageNamed:@"back_bbbb"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    
    UILabel *phoneTitleLabel = [[UILabel alloc] init];
    phoneTitleLabel.text = LocalizationKey(@"578Tip179");
    phoneTitleLabel.font = [UIFont systemFontOfSize:27];
    phoneTitleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:phoneTitleLabel];
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(52.5);
        make.centerX.mas_equalTo(self.view);
    }];
}




#pragma mark - 返回上个界面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
