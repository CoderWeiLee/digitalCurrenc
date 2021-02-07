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
@interface LWCloudRegisterViewController ()
@property (nonatomic, strong) UIButton *countryBtn;
@property (nonatomic, strong) CRBoxInputView *boxInputView1;
@property (nonatomic, strong) CRBoxInputView *boxInputView2;
@property (nonatomic, strong) CRBoxInputView *boxInputView3;
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
    
    // 添加box1
    CRBoxInputCellProperty *cellProperty1 = [CRBoxInputCellProperty new];
    cellProperty1.showLine = YES; //必需
    //背景颜色
    cellProperty1.cellBgColorNormal = [UIColor clearColor];
    cellProperty1.cellBgColorSelected = [UIColor clearColor];
    //边框颜色
    cellProperty1.cellBorderColorNormal = [UIColor clearColor];
    cellProperty1.cellBorderColorSelected = [UIColor clearColor];
//    //光标颜色
//    cellProperty1.cellCursorColor = [UIColor colorWithHexString:@"#F88D02"];
//    //光标宽度
    cellProperty1.cellCursorWidth = 0;
    //光标高度
    cellProperty1.cellCursorHeight = 0;
    //字体颜色
    cellProperty1.cellTextColor = [UIColor whiteColor];
    //字体大小
    cellProperty1.cellFont = [UIFont systemFontOfSize:40];
    cellProperty1.customLineViewBlock = ^CRLineView * _Nonnull{
        CRLineView *lineView = [CRLineView new];
        lineView.underlineColorNormal = [UIColor whiteColor];
        lineView.underlineColorSelected = [UIColor whiteColor];
        lineView.underlineColorFilled = [UIColor whiteColor];
        [lineView.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2);
            make.centerY.offset(0);
            make.width.mas_equalTo(5);
        }];
        return lineView;
    }; //可选
    self.boxInputView1 = [[CRBoxInputView alloc] initWithCodeLength:3];
    self.boxInputView1.customCellProperty = cellProperty1;
    [self.boxInputView1 loadAndPrepareViewWithBeginEdit:YES];
    [containerView1 addSubview:self.boxInputView1];
    [self.boxInputView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verLine.mas_right).offset(10);
        make.width.mas_equalTo(54);
        make.top.mas_equalTo(line1.mas_bottom);
        make.height.mas_equalTo(54);
    }];
    
    //添加容器视图2  2583542755
    UIView *containerView2 = [[UIView alloc] init];
    [self.view addSubview:containerView2];
    [containerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(line2);
        make.bottom.mas_equalTo(line3);
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
@end
