//
//  wodetuiguangViewController.m
//  digitalCurrenc
//
//  Created by work on 2020/11/14.
//

#import "wodetuiguangViewController.h"
#import "MineNetManager.h"
#import "tuiguangTableViewCell.h"

@interface wodetuiguangViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *arrays;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation wodetuiguangViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
//MARK:--获取广告数据信息
-(void)getData{
    [EasyShowLodingView showLodingText:[[ChangeLanguage bundle] localizedStringForKey:@"loading" value:nil table:@"English"]];
    
    [MineNetManager getPromoteFriendsPageno:@"1" ForCompleteHandle:^(id resPonseObj, int code) {
        [EasyShowLodingView hidenLoding];
        if (code) {
            if ([resPonseObj[@"code"] integerValue] == 0) {
                self.arrays = resPonseObj[@"data"];
                [self.tableview reloadData];
            }else{
                [self.view makeToast:resPonseObj[MESSAGE] duration:1.5 position:CSToastPositionCenter];
            }
        }else{
            [self.view makeToast:[[ChangeLanguage bundle] localizedStringForKey:@"noNetworkStatus" value:nil table:@"English"] duration:1.5 position:CSToastPositionCenter];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrays = [NSArray array];
    self.view.backgroundColor = [UIColor colorWithRed:24/255.0 green:34/255.0 blue:48/255.0 alpha:1.0];
    self.tableview.backgroundColor = [UIColor colorWithRed:24/255.0 green:34/255.0 blue:48/255.0 alpha:1.0];
    [self.tableview registerNib:[UINib nibWithNibName:@"tuiguangTableViewCell" bundle:nil] forCellReuseIdentifier:@"tuiguangTableViewCell"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getData];
    self.title =  LocalizationKey(@"myPromotion");
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrays.count + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tuiguangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tuiguangTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor colorWithRed:38/255.0 green:48/255.0 blue:61/255.0 alpha:1.0];
        cell.label3.textColor = [UIColor whiteColor];
        cell.label1.text = LocalizationKey(@"TUIGUANG1");
        cell.label2.text = LocalizationKey(@"TUIGUANG2");
        cell.label3.text = LocalizationKey(@"TUIGUANG3");
    }else{
        cell.backgroundColor = [UIColor colorWithRed:24/255.0 green:34/255.0 blue:48/255.0 alpha:1.0];
        cell.label3.textColor = [UIColor redColor];
        if (self.arrays.count >0) {
            NSDictionary *dic = self.arrays[indexPath.row - 1];
            cell.label1.text = dic[@"username"];
            cell.label2.text = dic[@"createTime"];
            int realNameStatus = [dic[@"realNameStatus"] intValue];
            if (realNameStatus == 2) {
                cell.label3.text = LocalizationKey(@"TUIGUANG5");
            }else{
                cell.label3.text = LocalizationKey(@"TUIGUANG4");
            }
      }
    }
    return cell;
}
@end
