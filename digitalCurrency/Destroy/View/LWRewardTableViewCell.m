//
//  LWRewardTableViewCell.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/22.
//  奖励

#import "LWRewardTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWRewardTableViewCell()
//容器视图
@property (nonatomic, strong) UIView *containerView;
//总投入量
@property (nonatomic, strong) UILabel *totalInvestTitleLabel;
@property (nonatomic, strong) UILabel *totalInvestAmountLabel;
//我的投入
@property (nonatomic, strong) UILabel *myInvestTitleLabel;
@property (nonatomic, strong) UILabel *myInvestAmountLabel;

//开源查询
@property (nonatomic, strong) UILabel *openSourceTitleLabel;
@property (nonatomic, strong) UIImageView *openSourceImageView;

//已获得ATO
@property (nonatomic, strong) UILabel *ownedATOTitleLabel;
@property (nonatomic, strong) UILabel *ownedATOAmountLabel;

//还可获得ATO
@property (nonatomic, strong) UILabel *surplusATOTitleLabel;
@property (nonatomic, strong) UILabel *surplusATOAmountLabel;
@end
@implementation LWRewardTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:16.0 / 255.0 green:16.0 / 255.0 blue:16.0 / 255.0 alpha:1];
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
        
        self.totalInvestTitleLabel = [[UILabel alloc] init];
        self.totalInvestTitleLabel.text = @"总投入量";
        self.totalInvestTitleLabel.font = [UIFont systemFontOfSize:11];
        self.totalInvestTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.totalInvestTitleLabel];
        [self.totalInvestTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.containerView).offset(11);
            make.top.mas_equalTo(self.containerView).offset(14);
        }];
        
        self.totalInvestAmountLabel = [[UILabel alloc] init];
        self.totalInvestAmountLabel.text = @"";
        self.totalInvestAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.totalInvestAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.totalInvestAmountLabel];
        [self.totalInvestAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.totalInvestTitleLabel);
            make.top.mas_equalTo(self.totalInvestTitleLabel.mas_bottom).offset(10);
        }];
        
        self.myInvestTitleLabel = [[UILabel alloc] init];
        self.myInvestTitleLabel.text = @"我的投入";
        self.myInvestTitleLabel.font = [UIFont systemFontOfSize:11];
        self.myInvestTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.myInvestTitleLabel];
        [self.myInvestTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.totalInvestTitleLabel);
        }];
        
        self.myInvestAmountLabel = [[UILabel alloc] init];
        self.myInvestAmountLabel.text = @"";
        self.myInvestAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.myInvestAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.myInvestAmountLabel];
        [self.myInvestAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.totalInvestAmountLabel);
        }];
        
        self.openSourceImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"opensource"]];
        [self.containerView addSubview:self.openSourceImageView];
        [self.openSourceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.myInvestTitleLabel).offset(-1.5);
            make.right.mas_equalTo(self.containerView).offset(-30);
            make.width.height.equalTo(@16);
        }];
        
        self.openSourceTitleLabel = [[UILabel alloc] init];
        self.openSourceTitleLabel.text = @"公开开源";
        self.openSourceTitleLabel.font = [UIFont systemFontOfSize:11];
        self.openSourceTitleLabel.textColor = [UIColor colorWithHexString:@"#F88D02"];
        [self.containerView addSubview:self.openSourceTitleLabel];
        [self.openSourceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.openSourceImageView);
            make.centerY.mas_equalTo(self.myInvestAmountLabel);
        }];
        
        
        self.ownedATOTitleLabel = [[UILabel alloc] init];
        self.ownedATOTitleLabel.text = @"已获得ATO";
        self.ownedATOTitleLabel.font = [UIFont systemFontOfSize:11];
        self.ownedATOTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.ownedATOTitleLabel];
        [self.ownedATOTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.totalInvestTitleLabel);
            make.top.mas_equalTo(self.totalInvestAmountLabel.mas_bottom).offset(20);
        }];
        
        self.ownedATOAmountLabel = [[UILabel alloc] init];
        self.ownedATOAmountLabel.text = @"";
        self.ownedATOAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.ownedATOAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.ownedATOAmountLabel];
        [self.ownedATOAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.ownedATOTitleLabel);
            make.top.mas_equalTo(self.ownedATOTitleLabel.mas_bottom).offset(8);
        }];
        
        self.surplusATOTitleLabel = [[UILabel alloc] init];
        self.surplusATOTitleLabel.text = @"还可获得ATO";
        self.surplusATOTitleLabel.font = [UIFont systemFontOfSize:11];
        self.surplusATOTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.surplusATOTitleLabel];
        [self.surplusATOTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.ownedATOTitleLabel);
        }];
        
        self.surplusATOAmountLabel = [[UILabel alloc] init];
        self.surplusATOAmountLabel.text = @"";
        self.surplusATOAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.surplusATOAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.surplusATOAmountLabel];
        [self.surplusATOAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.ownedATOAmountLabel);
        }];
        
        
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


- (void)setModel:(WWWWModel *)model {
    _model = model;
    self.totalInvestAmountLabel.text = _model.totalExchange;
    self.myInvestAmountLabel.text = _model.myValue;
    self.ownedATOAmountLabel.text = _model.bonusMoney;
    self.surplusATOAmountLabel.text = _model.lessBonusMoney;
    
}

@end
