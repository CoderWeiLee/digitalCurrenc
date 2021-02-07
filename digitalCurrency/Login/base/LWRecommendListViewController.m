//
//  LWRecommendListViewController.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/6.
//

#import "LWRecommendListViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
#import "LWRealNameTableViewCell.h"
@interface LWRecommendListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
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
    
    UIView *verLine = [[UIView alloc] init];
    verLine.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
    [topContainer addSubview:verLine];
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(30);
        make.center.mas_equalTo(topContainer);
    }];
    
    UIView *leftView = [[UIView alloc] init];
    [topContainer addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(topContainer);
        make.right.mas_equalTo(verLine.mas_left);
    }];
    
    UIView *rightView = [[UIView alloc] init];
    [topContainer addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(topContainer);
        make.left.mas_equalTo(verLine.mas_right);
    }];
    
    UILabel *leftTitle = [[UILabel alloc] init];
    leftTitle.text = @"挂买金额";
    leftTitle.textColor = [UIColor colorWithHexString:@"#999B9C"];
    leftTitle.font = [UIFont systemFontOfSize:11];
    [leftView addSubview:leftTitle];
    [leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftView).offset(18);
        make.centerX.mas_equalTo(leftView);
    }];
    
    UILabel *leftAmount = [[UILabel alloc] init];
    leftAmount.textColor = [UIColor colorWithHexString:@"#F88D02"];
    leftAmount.font = [UIFont systemFontOfSize:15];
    [leftView addSubview:leftAmount];
    [leftAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftTitle.mas_bottom).offset(11.5);
        make.centerX.mas_equalTo(leftView);
    }];
    
    
    
    UILabel *rightTitle = [[UILabel alloc] init];
    rightTitle.text = @"成交金额";
    rightTitle.textColor = [UIColor colorWithHexString:@"#999B9C"];
    rightTitle.font = [UIFont systemFontOfSize:11];
    [rightView addSubview:rightTitle];
    [rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightView).offset(18);
        make.centerX.mas_equalTo(rightView);
    }];
    
    UILabel *rightAmount = [[UILabel alloc] init];
    rightAmount.textColor = [UIColor colorWithHexString:@"#F88D02"];
    rightAmount.font = [UIFont systemFontOfSize:15];
    [rightView addSubview:rightAmount];
    [rightAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightTitle.mas_bottom).offset(11.5);
        make.centerX.mas_equalTo(rightView);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[LWRealNameTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LWRealNameTableViewCell class])];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topContainer.mas_bottom).offset(10);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    
}

#pragma mark - 返回上个界面
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LWRealNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWRealNameTableViewCell class]) forIndexPath:indexPath];
    
    return cell;
}



@end
