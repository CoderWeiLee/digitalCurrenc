//
//  ContactViewController.m
//  digitalCurrency
//
//  Created by startlink on 2019/7/7.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "ContactViewController.h"
#import "AccountSettingTableViewCell.h"
#import "AboutUSViewController.h"
#import "HtmlwebViewController.h"

@interface ContactViewController ()
{
    UIView *_lineView2;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [[ChangeLanguage bundle] localizedStringForKey:@"aboutUS" value:nil table:@"English"];
    [self.view addSubview:self.scrollView];
    [self initUI];
}

- (void)initUI{

    UILabel *ABC = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, kWindowW - 30, 20)];
    ABC.textColor = AppTextColor_Level_1;
    ABC.font = [UIFont systemFontOfSize:17];
    ABC.text = LocalizationKey(@"aboutABC");
    [self.scrollView addSubview:ABC];

    UILabel *about = [[UILabel alloc] init];
    about.text = LocalizationKey(@"aboutBUHUO");
    about.textColor = AppTextColor_Level_1;
    about.font = [UIFont systemFontOfSize:14];
    about.numberOfLines = 0;
    CGFloat height = [ToolUtil heightForString:LocalizationKey(@"aboutBUHUO") andWidth:kWindowW - 30 fontSize:14];
    about.frame = CGRectMake(15, CGRectGetMaxY(ABC.frame) + 30, kWindowW - 30, height);
    [self.scrollView addSubview:about];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(about.frame) + 15, kWindowW - 30, 1)];
    lineView.backgroundColor = RGBOF(0x333333);
    [self.scrollView addSubview:lineView];

    //ABC理念
    UILabel *idea = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView.frame) + 30, kWindowW - 30, 20)];
    idea.textColor = AppTextColor_Level_1;
    idea.font = [UIFont systemFontOfSize:17];
    idea.text = LocalizationKey(@"ABCIdea");
    [self.scrollView addSubview:idea];

    UILabel *ideaLabel = [[UILabel alloc] init];
    ideaLabel.text = LocalizationKey(@"Idea");
    ideaLabel.textColor = AppTextColor_Level_1;
    ideaLabel.font = [UIFont systemFontOfSize:14];
    ideaLabel.numberOfLines = 0;
    CGFloat height1 = [ToolUtil heightForString:LocalizationKey(@"Idea") andWidth:kWindowW - 30 fontSize:14];
    ideaLabel.frame = CGRectMake(15, CGRectGetMaxY(idea.frame) + 30, kWindowW - 30, height1);
    [self.scrollView addSubview:ideaLabel];

    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(ideaLabel.frame) + 15, kWindowW - 30, 1)];
    lineView1.backgroundColor = RGBOF(0x333333);
    [self.scrollView addSubview:lineView1];

    //ABC目标
    UILabel *target = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView1.frame) + 30, kWindowW - 30, 20)];
    target.textColor = AppTextColor_Level_1;
    target.font = [UIFont systemFontOfSize:17];
    target.text = LocalizationKey(@"ABCTarget");
    [self.scrollView addSubview:target];

    UILabel *targetLabel = [[UILabel alloc] init];
    targetLabel.text = LocalizationKey(@"target");
    targetLabel.textColor = AppTextColor_Level_1;
    targetLabel.font = [UIFont systemFontOfSize:14];
    targetLabel.numberOfLines = 0;
    CGFloat height2 = [ToolUtil heightForString:LocalizationKey(@"target") andWidth:kWindowW - 30 fontSize:14];
    targetLabel.frame = CGRectMake(15, CGRectGetMaxY(target.frame) + 30, kWindowW - 30, height2);
    [self.scrollView addSubview:targetLabel];

    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(targetLabel.frame) + 15, kWindowW - 30, 1)];
    _lineView2 = lineView2;
    lineView2.backgroundColor = RGBOF(0x333333);
    [self.scrollView addSubview:lineView2];

    //联系我们
    UILabel *contact = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView2.frame) + 30, kWindowW - 30, 20)];
    contact.textColor = AppTextColor_Level_1;
    contact.font = [UIFont systemFontOfSize:17];
    contact.text = LocalizationKey(@"Contactus");
    [self.scrollView addSubview:contact];

//    UIImageView *kefu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WechatIMG16"]];
//    kefu.frame = CGRectMake(0, 0, 145 * kWindowWHOne, 145 * kWindowWHOne);
//    kefu.center = CGPointMake(kWindowW / 2, CGRectGetMaxY(contact.frame) + 25 + (145 * kWindowWHOne) / 2);
//    [self.scrollView addSubview:kefu];

    UILabel *kefuLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(contact.frame) + 10, kWindowW - 30, 15)];
    kefuLabel.textColor = AppTextColor_Level_1;
    kefuLabel.font = [UIFont systemFontOfSize:14];
    kefuLabel.text = @"ABC邮箱：admin@ABCex.com";
//    kefuLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:kefuLabel];

    UIImageView *qun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WechatIMG17"]];
    qun.frame = CGRectMake(0, 0, 145 * kWindowWHOne, 145 * kWindowWHOne);
    qun.hidden = YES;
    qun.center = CGPointMake(kWindowW / 2, CGRectGetMaxY(kefuLabel.frame) + 25 + (145 * kWindowWHOne) / 2);
    [self.scrollView addSubview:qun];

    UILabel *qunLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(qun.frame) + 10, kWindowW - 30, 15)];
    qunLabel.textAlignment = NSTextAlignmentCenter;
    qunLabel.textColor = AppTextColor_Level_1;
    qunLabel.font = [UIFont systemFontOfSize:14];
    qunLabel.text = LocalizationKey(@"Community");
    qunLabel.hidden = YES;
    [self.scrollView addSubview:qunLabel];

    self.scrollView.contentSize = CGSizeMake(kWindowW, CGRectGetMaxY(qunLabel.frame) + 50);
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH - NEW_NavHeight)];
        _scrollView.backgroundColor = mainColor;
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 944)];
//        imageView.image = [UIImage imageNamed:@"shuiyinlogo"];
////        [_scrollView addSubview:imageView];
//        [_scrollView insertSubview:imageView atIndex:0];
    }
    return _scrollView;
}

@end
