//
//  LWCloudLoginViewController.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/4.
//

#import "LWCloudLoginViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWCloudLoginViewController ()
@property (nonatomic, strong) UIImageView *countryImgV;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UILabel *countryCodeLabel;
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
    
    self.countryImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"china"]];
    [self.view addSubview:self.countryImgV];
    [self.countryImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@18);
        make.left.mas_equalTo(line1).offset(7.5);
        make.top.mas_equalTo(line1.mas_bottom).offset(18.5);
    }];
    
    self.countryLabel = [[UILabel alloc] init];
    self.countryLabel.text = LocalizationKey(@"china");
    self.countryLabel.font = [UIFont systemFontOfSize:17];
    self.countryLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.countryLabel];
    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countryImgV.mas_right).offset(18);
        make.centerY.mas_equalTo(self.countryImgV);
    }];
    
    UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    [self.view addSubview:rightArrow];
    [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(line1).offset(-1);
        make.centerY.mas_equalTo(self.countryImgV);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.top.mas_equalTo(self.countryImgV.mas_bottom).offset(17.5);
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
        make.left.mas_equalTo(self.countryCodeLabel.mas_right).offset(26);
        make.width.mas_equalTo(@1);
        make.top.mas_equalTo(line2.mas_bottom);
    }];
    
   
    
}




#pragma mark - 返回上个界面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
