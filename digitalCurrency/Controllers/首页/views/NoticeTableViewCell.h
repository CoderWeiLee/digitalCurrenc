//
//  NoticeTableViewCell.h
//  digitalCurrency
//
//  Created by startlink on 2019/7/31.
//  Copyright © 2019年 ABC. All rights reserved.
//

@protocol xindelegate <NSObject>

-(void)recharge;
-(void)destory;
-(void)wangge;
-(void)deal;
-(void)help;
-(void)Fdeal;
-(void)Bdeal;
-(void)GongGao;

@end

#import <UIKit/UIKit.h>

@interface NoticeTableViewCell : UITableViewCell

@property(nonatomic,assign)id<xindelegate>delegate;



@property (weak, nonatomic) IBOutlet UIImageView *view1;
@property (weak, nonatomic) IBOutlet UILabel *label1;



@property (weak, nonatomic) IBOutlet UIImageView *view2;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UIImageView *view3;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UIImageView *view4;
@property (weak, nonatomic) IBOutlet UILabel *label4;


@property (weak, nonatomic) IBOutlet UIImageView *view5;
@property (weak, nonatomic) IBOutlet UILabel *label5;

@property (weak, nonatomic) IBOutlet UIImageView *view6;
@property (weak, nonatomic) IBOutlet UILabel *label6;

@property (weak, nonatomic) IBOutlet UIImageView *view7;
@property (weak, nonatomic) IBOutlet UILabel *label7;

@property (weak, nonatomic) IBOutlet UIImageView *view8;
@property (weak, nonatomic) IBOutlet UILabel *label8;





@property (weak, nonatomic) IBOutlet UIView *transactionview;
@property (weak, nonatomic) IBOutlet UIView *helpView;
@property (weak, nonatomic) IBOutlet UILabel *transactionlabel;
@property (weak, nonatomic) IBOutlet UILabel *safelabel;
@property (weak, nonatomic) IBOutlet UIView *Noticeview;
@property (nonatomic,copy)void (^CtoCBlock)(void);


@property (weak, nonatomic) IBOutlet UILabel *add1label;
@property (weak, nonatomic) IBOutlet UILabel *add2label;
@property (weak, nonatomic) IBOutlet UILabel *add3label;
@property (weak, nonatomic) IBOutlet UILabel *add4label;
@property (weak, nonatomic) IBOutlet UILabel *add5label;
@property (weak, nonatomic) IBOutlet UILabel *add6label;
@property (weak, nonatomic) IBOutlet UILabel *add7label;
@property (weak, nonatomic) IBOutlet UILabel *add8label;

@end
