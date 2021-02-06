//
//  LWRecommendListViewController.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/6.
//

#import "LWRecommendListViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWRecommendListViewController ()

@end

@implementation LWRecommendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = LocalizationKey(@"578Tip182");
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
    
    UIView *topContainer = [[UIView alloc] init];
    topContainer.backgroundColor = [UIColor colorWithHexString:@"#212223"];
    topContainer.layer.cornerRadius = 5;
    topContainer.layer.masksToBounds = YES;
    [self.view addSubview:topContainer];
    [topContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(19.5);
        make.height.mas_equalTo(157);
    }];
    
    UILabel *countTitle = [[UILabel alloc] init];
    countTitle.text = LocalizationKey(@"578Tip183");
    countTitle.textColor = [UIColor whiteColor];
    countTitle.font = [UIFont systemFontOfSize:14];
    [topContainer addSubview:countTitle];
    [countTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topContainer);
        make.top.mas_equalTo(topContainer).offset(21.5);
    }];
    
    UILabel *countAmount = [[UILabel alloc] init];
    countAmount.textColor = [UIColor colorWithHexString:@"#F88D02"];
    countAmount.font = [UIFont systemFontOfSize:25];
    [topContainer addSubview:countAmount];
    [countAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topContainer);
        make.top.mas_equalTo(countTitle.mas_bottom).offset(15);
    }];
    
    UIView *sepLine = [[UIView alloc] init];
    sepLine.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
    [topContainer addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topContainer).offset(12.5);
        make.right.mas_equalTo(topContainer).offset(-12.5);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(countAmount.mas_bottom).offset(17);
    }];
    
    
    
}

#pragma mark - 返回上个界面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
