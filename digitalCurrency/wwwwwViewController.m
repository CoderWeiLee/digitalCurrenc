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
#import <AFNetworking/AFNetworking.h>
#import "WWWWListModel.h"
#import "MBProgressHUD.h"
@interface wwwwwViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WWWWModel *model;
@property (nonatomic, strong) WWWWListModel *listModel;
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
    [self refresh];
}

- (void)refresh {
    [BaseNetManager requestWithPost:@"http://12345.abc.tm/device/index/info" header:@{@"token": [YLUserInfo shareUserInfo].token} parameters:nil successBlock:^(NSDictionary *resultObject, int isSuccessed) {
        if ([resultObject[@"message"] isEqualToString:@"success"]) {
            self.model = [WWWWModel mj_objectWithKeyValues:resultObject[@"data"]];
            [self.tableView reloadData];
        }
    }];
    
    //1.获取矿机列表
    [BaseNetManager requestWithGET:@"device/index/list" parameters:nil successBlock:^(NSDictionary *resultObject, int isSuccessed) {
        if ([resultObject[@"message"] isEqualToString:@"success"]) {
            self.listModel = [WWWWListModel mj_objectWithKeyValues:resultObject[@"data"][0]];
            NSLog(@"111");
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
            return 120;
        case 4:
            return 80;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }
        case 1:
        {
            LWDestroyAmountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWDestroyAmountTableViewCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return  cell;
        }
        case 2:
        {
            LWCirculateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWCirculateTableViewCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return  cell;
        }
        case 3:
        {
            LWRewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWRewardTableViewCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return  cell;
        }
        case 4:
        {
            LWLockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWLockTableViewCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return  cell;
        }
        case 5:
        {
            LWEnergyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWEnergyTableViewCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            cell.listModel = self.listModel;
            cell.buySuccessBlock = ^(NSString * _Nonnull msg) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = msg;
                hud.mode = MBProgressHUDModeText;
                [hud showAnimated:YES];
                [hud hideAnimated:YES afterDelay:1.0];
                [self refresh];
            };
            return  cell;
        }

        default:
        {
            LWEnergyBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWEnergyBottomTableViewCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return  cell;
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
@end
