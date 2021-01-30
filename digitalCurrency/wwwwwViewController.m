//
//  PlatformMessageDetailViewController.m
//  digitalCurrency
//
//  Created by iDog on 2019/3/21.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "wwwwwViewController.h"
#import <Masonry/Masonry.h>
#import "LWDestroyHeaderCell.h"
#import "ReqestHelpManager.h"
#import "AFNetworkClass.h"
#import "BaseNetManager.h"
#import <MJExtension/MJExtension.h>
#import "WWWWModel.h"
#import "LWDestroyAmountTableViewCell.h"
#import "LWCirculateTableViewCell.h"
#import "LWRewardTableViewCell.h"
#import "LWLockTableViewCell.h"
#import "LWEnergyTableViewCell.h"
#import "LWEnergyBottomTableViewCell.h"
@interface wwwwwViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WWWWModel *model;
@end

@implementation wwwwwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:16.0 / 255.0 green:16.0 / 255.0 blue:16.0 / 255.0 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = [UIColor colorWithRed:16.0 / 255.0 green:16.0 / 255.0 blue:16.0 / 255.0 alpha:1];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerClass:[LWDestroyHeaderCell class] forCellReuseIdentifier:NSStringFromClass([LWDestroyHeaderCell class])];
    [self.tableView registerClass:[LWDestroyAmountTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LWDestroyAmountTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[LWCirculateTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LWCirculateTableViewCell class])];
    [self.tableView registerClass:[LWRewardTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LWRewardTableViewCell class])];
    [self.tableView registerClass:[LWLockTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LWLockTableViewCell class])];
    [self.tableView registerClass:[LWEnergyTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LWEnergyTableViewCell class])];
    [self.tableView registerClass:[LWEnergyBottomTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LWEnergyBottomTableViewCell class])];
    [BaseNetManager requestWithPost:@"http://12345.abc.tm/device/index/info" header:@{@"token": [YLUserInfo shareUserInfo].token} parameters:nil successBlock:^(NSDictionary *resultObject, int isSuccessed) {
        if ([resultObject[@"message"] isEqualToString:@"success"]) {
            self.model = [WWWWModel mj_objectWithKeyValues:resultObject[@"data"]];
            [self.tableView reloadData];
        }
    }];
}




#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 80;
        case 1:
            return 80;
        case 2:
            return 80;
        case 3:
            return 150;
        case 4:
            return 150;
        case 5:
            return 400;
        default:
            return 120;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            LWDestroyHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWDestroyHeaderCell class]) forIndexPath:indexPath];
            return  cell;
        }
        case 1:
        {
            LWDestroyAmountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWDestroyAmountTableViewCell class]) forIndexPath:indexPath];
            cell.model = self.model;
            return  cell;
        }
        case 2:
        {
            LWCirculateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWCirculateTableViewCell class]) forIndexPath:indexPath];
            cell.model = self.model;
            return  cell;
        }
        case 3:
        {
            LWRewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWRewardTableViewCell class]) forIndexPath:indexPath];
            cell.model = self.model;
            return  cell;
        }
        case 4:
        {
            LWLockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWLockTableViewCell class]) forIndexPath:indexPath];
            cell.model = self.model;
            return  cell;
        }
        case 5:
        {
            LWEnergyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWEnergyTableViewCell class]) forIndexPath:indexPath];
            cell.model = self.model;
            return  cell;
        }

        default:
        {
            LWEnergyBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWEnergyBottomTableViewCell class]) forIndexPath:indexPath];
            cell.model = self.model;
            return  cell;
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
@end
