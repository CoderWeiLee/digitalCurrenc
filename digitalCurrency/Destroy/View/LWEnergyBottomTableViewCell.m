//
//  LWEnergyBottomTableViewCell.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/23.
//  最底部的cell-持有能量

#import "LWEnergyBottomTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWEnergyBottomTableViewCell()
//容器视图
@property (nonatomic, strong) UIView *containerView;
//持有的
@property (nonatomic, strong) UILabel *ownTitleLabel;
@property (nonatomic, strong) UILabel *ownAmountLabel;

@property (nonatomic, strong) UILabel *myTitleLabel;
@property (nonatomic, strong) UILabel *myAmountLabel;
@end

@implementation LWEnergyBottomTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:16.0 / 255.0 green:16.0 / 255.0 blue:16.0 / 255.0 alpha:1];
        self.containerView = [[UIView alloc] init];
        self.containerView.backgroundColor = [UIColor colorWithRed:30.0 / 255.0 green:30.0 / 255.0 blue:30.0 / 255.0 alpha:1];
        self.containerView.layer.cornerRadius = 5;
        self.containerView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.containerView];
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
        }];
        
        self.ownTitleLabel = [[UILabel alloc] init];
        self.ownTitleLabel.text = @"持有能量";
        self.ownTitleLabel.font = [UIFont systemFontOfSize:11];
        self.ownTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.ownTitleLabel];
        [self.ownTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.containerView).offset(11);
            make.top.mas_equalTo(self.containerView).offset(14);
        }];
        
        self.ownAmountLabel = [[UILabel alloc] init];
        self.ownAmountLabel.text = @"";
        self.ownAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.ownAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.ownAmountLabel];
        [self.ownAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.ownTitleLabel);
            make.top.mas_equalTo(self.ownTitleLabel.mas_bottom).offset(8);
        }];
        
        self.myTitleLabel = [[UILabel alloc] init];
        self.myTitleLabel.text = @"我的能量";
        self.myTitleLabel.font = [UIFont systemFontOfSize:11];
        self.myTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.myTitleLabel];
        [self.myTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.containerView).offset(-11.5);
            make.centerY.mas_equalTo(self.ownTitleLabel);
        }];
        
        self.myAmountLabel = [[UILabel alloc] init];
        self.myAmountLabel.text = @"";
        self.myAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.myAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.myAmountLabel];
        [self.myAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.ownAmountLabel);
            make.top.mas_equalTo(self.myTitleLabel.mas_bottom).offset(8);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setModel:(WWWWModel *)model {
    _model = model;
}

@end
