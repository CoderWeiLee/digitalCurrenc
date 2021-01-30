//
//  LWLockTableViewCell.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/23.
//  针对锁定的

#import "LWLockTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWLockTableViewCell()
//容器视图
@property (nonatomic, strong) UIView *containerView;
//ATO锁定中
@property (nonatomic, strong) UILabel *lockTitleLabel;
@property (nonatomic, strong) UILabel *lockAmountLabel;

//ATO已释放
@property (nonatomic, strong) UILabel *releaseTitleLabel;
@property (nonatomic, strong) UILabel *releaseAmountLabel;
@end
@implementation LWLockTableViewCell
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
        
        self.lockTitleLabel = [[UILabel alloc] init];
        self.lockTitleLabel.text = @"ATO锁定中";
        self.lockTitleLabel.font = [UIFont systemFontOfSize:11];
        self.lockTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.lockTitleLabel];
        [self.lockTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.containerView).offset(11);
            make.top.mas_equalTo(self.containerView).offset(14);
        }];
        [self.containerView addSubview:self.lockTitleLabel];
        
        self.lockAmountLabel = [[UILabel alloc] init];
        self.lockAmountLabel.text = @"";
        self.lockAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.lockAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.lockAmountLabel];
        [self.lockAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lockTitleLabel);
            make.top.mas_equalTo(self.lockTitleLabel.mas_bottom).offset(8);
        }];
        
        self.releaseTitleLabel = [[UILabel alloc] init];
        self.releaseTitleLabel.text = @"ATO已释放";
        self.releaseTitleLabel.font = [UIFont systemFontOfSize:11];
        self.releaseTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.releaseTitleLabel];
        [self.releaseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.lockTitleLabel);
        }];
        
        self.releaseAmountLabel = [[UILabel alloc] init];
        self.releaseAmountLabel.text = @"";
        self.releaseAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.releaseAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.releaseAmountLabel];
        [self.releaseAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.lockAmountLabel);
        }];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setModel:(WWWWModel *)model {
    _model = model;
    self.lockAmountLabel.text = _model.lockMoney;
    self.releaseAmountLabel.text = _model.unLockMoney;
}

@end
