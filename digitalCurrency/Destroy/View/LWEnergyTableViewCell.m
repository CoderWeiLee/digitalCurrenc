//
//  LWEnergyTableViewCell.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/23.
//  能量池

#import "LWEnergyTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWEnergyTableViewCell()
//容器视图
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *energyImageView;
@property (nonatomic, strong) UILabel *expLabel1;
@property (nonatomic, strong) UILabel *expLabel2;
@property (nonatomic, strong) UILabel *expLabel3;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;
@property (nonatomic, strong) UIButton *btn5;
@property (nonatomic, strong) UIButton *commitBtn;
@end
@implementation LWEnergyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.containerView = [[UIView alloc] init];
        self.containerView.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
        self.containerView.layer.cornerRadius = 5;
        self.containerView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.containerView];
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
        }];
        
        self.energyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"energy"]];
        [self.containerView addSubview:self.energyImageView];
        [self.energyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.containerView).offset(11);
            make.centerX.mas_equalTo(self.containerView);
        }];
        
        self.expLabel1 = [[UILabel alloc] init];
        self.expLabel1.text = @"投入能量池即可销毁ACT，ACT衰减性减少";
        self.expLabel1.textAlignment = NSTextAlignmentCenter;
        self.expLabel1.textColor = [UIColor colorWithHexString:@"#F88D02"];
        self.expLabel1.font = [UIFont systemFontOfSize:12];
        [self.containerView addSubview:self.expLabel1];
        [self.expLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.containerView);
            make.top.mas_equalTo(self.energyImageView.mas_bottom).offset(10.5);
        }];
        
        self.expLabel2 = [[UILabel alloc] init];
        self.expLabel2.text = @"公开！透明！创新！";
        self.expLabel2.textAlignment = NSTextAlignmentCenter;
        self.expLabel2.textColor = [UIColor colorWithHexString:@"#F88D02"];
        self.expLabel2.font = [UIFont systemFontOfSize:12];
        [self.containerView addSubview:self.expLabel2];
        [self.expLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.containerView);
            make.top.mas_equalTo(self.expLabel1.mas_bottom).offset(10);
        }];
        
        self.expLabel3 = [[UILabel alloc] init];
        self.expLabel3.text = @"循环销毁，激励上涨，开启新阶段交易！";
        self.expLabel3.textAlignment = NSTextAlignmentCenter;
        self.expLabel3.textColor = [UIColor colorWithHexString:@"#F88D02"];
        self.expLabel3.font = [UIFont systemFontOfSize:12];
        [self.containerView addSubview:self.expLabel3];
        [self.expLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.containerView);
            make.top.mas_equalTo(self.expLabel2.mas_bottom).offset(10);
        }];
        
        self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btn1 setTitle:@"0U" forState:UIControlStateNormal];
        self.btn1.tag = 1;
        [self.btn1 setTitle:@"0U" forState:UIControlStateSelected];
        [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        self.btn1.titleLabel.font = [UIFont systemFontOfSize:15];
        self.btn1.backgroundColor = [UIColor colorWithHexString:@"#F68D25"];
        self.btn1.layer.cornerRadius = 3;
        self.btn1.layer.masksToBounds = YES;
        [self.btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:self.btn1];
        [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@30);
            make.left.mas_equalTo(self.containerView).offset(11);
            make.top.mas_equalTo(self.expLabel3.mas_bottom).offset(17.5);
        }];
        
        self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btn2 setTitle:@"100U" forState:UIControlStateNormal];
        self.btn2.tag = 2;
        [self.btn2 setTitle:@"100U" forState:UIControlStateSelected];
        [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        self.btn2.titleLabel.font = [UIFont systemFontOfSize:15];
        self.btn2.backgroundColor = [UIColor colorWithHexString:@"#F68D25"];
        self.btn2.layer.cornerRadius = 3;
        self.btn2.layer.masksToBounds = YES;
        [self.btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:self.btn2];
        [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@30);
            make.left.mas_equalTo(self.btn1.mas_right).offset(5.5);
            make.centerY.mas_equalTo(self.btn1);
        }];
        
        self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btn3 setTitle:@"500U" forState:UIControlStateNormal];
        self.btn3.tag = 3;
        [self.btn3 setTitle:@"500U" forState:UIControlStateSelected];
        [self.btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        self.btn3.titleLabel.font = [UIFont systemFontOfSize:15];
        self.btn3.backgroundColor = [UIColor colorWithHexString:@"#F68D25"];
        self.btn3.layer.cornerRadius = 3;
        self.btn3.layer.masksToBounds = YES;
        [self.btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:self.btn3];
        [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@30);
            make.left.mas_equalTo(self.btn2.mas_right).offset(5.5);
            make.centerY.mas_equalTo(self.btn1);
        }];
        
        self.btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btn4 setTitle:@"1000U" forState:UIControlStateNormal];
        self.btn4.tag = 4;
        [self.btn4 setTitle:@"1000U" forState:UIControlStateSelected];
        [self.btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        self.btn4.titleLabel.font = [UIFont systemFontOfSize:15];
        self.btn4.backgroundColor = [UIColor colorWithHexString:@"#F68D25"];
        self.btn4.layer.cornerRadius = 4;
        self.btn4.layer.masksToBounds = YES;
        [self.btn4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:self.btn4];
        [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@30);
            make.left.mas_equalTo(self.btn3.mas_right).offset(5.5);
            make.centerY.mas_equalTo(self.btn1);
        }];
        
        self.btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btn5 setTitle:@"1500U" forState:UIControlStateNormal];
        self.btn5.tag = 5;
        [self.btn5 setTitle:@"1500U" forState:UIControlStateSelected];
        [self.btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        self.btn5.titleLabel.font = [UIFont systemFontOfSize:15];
        self.btn5.backgroundColor = [UIColor colorWithHexString:@"#F68D25"];
        self.btn5.layer.cornerRadius = 3;
        self.btn5.layer.masksToBounds = YES;
        [self.btn5 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:self.btn5];
        [self.btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@30);
            make.left.mas_equalTo(self.btn4.mas_right).offset(5.5);
            make.centerY.mas_equalTo(self.btn1);
        }];
        
        self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.commitBtn setTitle:@"投入能量池" forState:UIControlStateNormal];
        [self.commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        self.commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.commitBtn.backgroundColor = [UIColor colorWithHexString:@"#F68D25"];
        self.commitBtn.layer.cornerRadius = 3;
        self.commitBtn.layer.masksToBounds = YES;
        [self.commitBtn addTarget:self action:@selector(commmitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:self.commitBtn];
        [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@200);
            make.height.mas_equalTo(@30);
            make.centerX.mas_equalTo(self.containerView);
            make.top.mas_equalTo(self.btn1.mas_bottom).offset(22);
        }];
    }
    return self;
}

- (void)btnAction:(UIButton *)btn {
    
}

- (void)commmitAction:(UIButton *)btn {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
