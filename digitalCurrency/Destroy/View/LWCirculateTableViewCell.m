//
//  LWCirculateTableViewCell.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/22.
//  流通

#import "LWCirculateTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWCirculateTableViewCell()
//容器视图
@property (nonatomic, strong) UIView *containerView;
//当前流通
@property (nonatomic, strong) UILabel *currentTitleLabel;
@property (nonatomic, strong) UILabel *currentAmountLabel;
//今日质押
@property (nonatomic, strong) UILabel *pledgeTitleLabel;
@property (nonatomic, strong) UILabel *pledgeAmountLabel;
//今日产出
@property (nonatomic, strong) UILabel *produceTitleLabel;
@property (nonatomic, strong) UILabel *produceAmountLabel;
@end
@implementation LWCirculateTableViewCell
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
        
        self.currentTitleLabel = [[UILabel alloc] init];
        self.currentTitleLabel.text = @"当前流通";
        self.currentTitleLabel.font = [UIFont systemFontOfSize:11];
        self.currentTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.currentTitleLabel];
        [self.currentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.containerView).offset(11);
            make.top.mas_equalTo(self.containerView).offset(14);
        }];
        
        self.currentAmountLabel = [[UILabel alloc] init];
        self.currentAmountLabel.text = @"";
        self.currentAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.currentAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.currentAmountLabel];
        [self.currentAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.currentTitleLabel);
            make.top.mas_equalTo(self.currentTitleLabel.mas_bottom).offset(8);
        }];
        
        self.pledgeTitleLabel = [[UILabel alloc] init];
        self.pledgeTitleLabel.text = @"今日质押";
        self.pledgeTitleLabel.font = [UIFont systemFontOfSize:11];
        self.pledgeTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.pledgeTitleLabel];
        [self.pledgeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.currentTitleLabel);
        }];
        
        self.pledgeAmountLabel = [[UILabel alloc] init];
        self.pledgeAmountLabel.text = @"";
        self.pledgeAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.pledgeAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.pledgeAmountLabel];
        [self.pledgeAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.currentAmountLabel);
        }];
        
        self.produceTitleLabel = [[UILabel alloc] init];
        self.produceTitleLabel.text = @"今日产出";
        self.produceTitleLabel.font = [UIFont systemFontOfSize:11];
        self.produceTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.produceTitleLabel];
        [self.produceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.containerView).offset(-11.5);
            make.centerY.mas_equalTo(self.currentTitleLabel);
        }];
        
        self.produceAmountLabel = [[UILabel alloc] init];
        self.produceAmountLabel.text = @"";
        self.produceAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.produceAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.produceAmountLabel];
        [self.produceAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.produceTitleLabel);
            make.centerY.mas_equalTo(self.currentAmountLabel);
        }];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(WWWWModel *)model {
    _model = model;
    self.produceAmountLabel.text = _model.todayBonus;
    self.pledgeAmountLabel.text = _model.todayExchange;
    self.currentAmountLabel.text = [NSString stringWithFormat:@"%d",[_model.todayExchange intValue] - [_model.todayBonus intValue]];
}

@end
