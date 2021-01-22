//
//  NoticeTableViewCell.m
//  digitalCurrency
//
//  Created by startlink on 2019/7/31.
//  Copyright © 2019年 ABC. All rights reserved.
//


#import "NoticeTableViewCell.h"
#import "HelpeCenterViewController.h"
#import "NoticeCenterViewController.h"
@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.transactionview.backgroundColor = blackcolor;
    self.helpView.backgroundColor = blackcolor;
    self.Noticeview.backgroundColor = blackcolor;
    self.contentView.backgroundColor = [UIColor blackColor];
    self.transactionview.userInteractionEnabled = YES;
    self.helpView.userInteractionEnabled = YES;
    self.Noticeview.userInteractionEnabled = YES;



    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transactionaction)];
    [self.view1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transactionaction)];

    [self.label1 addGestureRecognizer:tap11];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(destory)];
    
    UITapGestureRecognizer *tap22 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(destory)];
    
    [self.view2 addGestureRecognizer:tap2];
    [self.label2 addGestureRecognizer:tap22];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wangge)];
    UITapGestureRecognizer *tap33 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wangge)];
    [self.view3 addGestureRecognizer:tap3];
    [self.label3 addGestureRecognizer:tap33];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transactionaction)];
    UITapGestureRecognizer *tap44 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transactionaction)];
    [self.view4 addGestureRecognizer:tap4];
    [self.label4 addGestureRecognizer:tap44];
    
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(helpaction)];
    [self.view5 addGestureRecognizer:tap5];
    
    UITapGestureRecognizer *tap55 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(helpaction)];

    [self.label5 addGestureRecognizer:tap55];
    
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transactionaction)];
    [self.view6 addGestureRecognizer:tap6];
    UITapGestureRecognizer *tap66 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transactionaction)];

    [self.label6 addGestureRecognizer:tap66];
    
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baoben)];
    UITapGestureRecognizer *tap77 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baoben)];

    [self.view7 addGestureRecognizer:tap7];
    [self.label7 addGestureRecognizer:tap77];
    
    
    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noticeaction)];
    UITapGestureRecognizer *tap88 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noticeaction)];

    [self.view8 addGestureRecognizer:tap8];
    [self.label8 addGestureRecognizer:tap88];
    
    
    
    // LocalizationKey(@"noLongerReminding")
    
    self.add1label.text = LocalizationKey(@"add1");
    self.add2label.text = LocalizationKey(@"add2");
    self.add3label.text = LocalizationKey(@"add3");
    self.add4label.text = LocalizationKey(@"add4");
    self.add5label.text = LocalizationKey(@"add5");
    self.add6label.text = LocalizationKey(@"add6");
    self.add7label.text = LocalizationKey(@"add7");
    self.add8label.text = LocalizationKey(@"add8");
    
}
//销毁交易
-(void)destory{
    // http://1021.weikuaikeji.com/#/lab
    [self.delegate destory];
}
//网格交易
-(void)wangge{
    [self.delegate wangge];
  //  点开提示  只针对abc10万以上用户
}
//保本交易
-(void)baoben{
    [self.delegate Bdeal];
    // 点开提示  只针对abc内部用户
}


//法币交易
-(void)transactionaction{
    self.CtoCBlock();
}

//帮助中心
-(void)helpaction{
    
    HelpeCenterViewController *help = [[HelpeCenterViewController alloc] init];
    [[AppDelegate sharedAppDelegate] pushViewController:help];
}

//公告中心
-(void)noticeaction{
//    NoticeCenterViewController *NoticeVC = [NoticeCenterViewController new];
//    [[AppDelegate sharedAppDelegate] pushViewController:NoticeVC];
    HelpeCenterViewController *help = [[HelpeCenterViewController alloc] init];
    [[AppDelegate sharedAppDelegate] pushViewController:help];
}








@end
