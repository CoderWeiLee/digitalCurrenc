//
//  LWDestroyAmountTableViewCell.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/22.
//

#import "LWDestroyAmountTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWDestroyAmountTableViewCell()
//容器视图
@property (nonatomic, strong) UIView *containerView;
//ACT
@property (nonatomic, strong) UILabel *actTitleLabel;
@property (nonatomic, strong) UILabel *actAmountLabel;
//销毁
@property (nonatomic, strong) UILabel *desTitleLabel;
@property (nonatomic, strong) UILabel *desAmountLabel;
//剩余
@property (nonatomic, strong) UILabel *remainTitleLabel;
@property (nonatomic, strong) UILabel *remainAmountLabel;
@end
@implementation LWDestroyAmountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:16.0 / 255.0 green:16.0 / 255.0 blue:16.0 / 255.0 alpha:1];
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
        
        self.actTitleLabel = [[UILabel alloc] init];
        self.actTitleLabel.text = @"ACT总量";
        self.actTitleLabel.font = [UIFont systemFontOfSize:11];
        self.actTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.actTitleLabel];
        [self.actTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.containerView).offset(11);
            make.top.mas_equalTo(self.containerView).offset(14);
        }];
        
        self.actAmountLabel = [[UILabel alloc] init];
        self.actAmountLabel.text = @"";
        self.actAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.actAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.actAmountLabel];
        [self.actAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.actTitleLabel);
            make.top.mas_equalTo(self.actTitleLabel.mas_bottom).offset(8);
        }];
        
        self.desTitleLabel = [[UILabel alloc] init];
        self.desTitleLabel.text = @"销毁数量";
        self.desTitleLabel.font = [UIFont systemFontOfSize:11];
        self.desTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.desTitleLabel];
        [self.desTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.actTitleLabel);
        }];
        
        self.desAmountLabel = [[UILabel alloc] init];
        self.desAmountLabel.text = @"";
        self.desAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.desAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.desAmountLabel];
        [self.desAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.actAmountLabel);
        }];
        
        self.remainTitleLabel = [[UILabel alloc] init];
        self.remainTitleLabel.text = @"剩余总量";
        self.remainTitleLabel.font = [UIFont systemFontOfSize:11];
        self.remainTitleLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.containerView addSubview:self.remainTitleLabel];
        [self.remainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.containerView).offset(-11.5);
            make.centerY.mas_equalTo(self.actTitleLabel);
        }];
        
        self.remainAmountLabel = [[UILabel alloc] init];
        self.remainAmountLabel.text = @"";
        self.remainAmountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.remainAmountLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview:self.remainAmountLabel];
        [self.remainAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.remainTitleLabel);
            make.centerY.mas_equalTo(self.actAmountLabel);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(WWWWModel *)model {
    _model = model;
    self.actAmountLabel.text = _model.actTotal;
    self.desAmountLabel.text = _model.actDestory;
    self.remainAmountLabel.text = [NSString stringWithFormat:@"%d",[_model.actTotal intValue] - [_model.actDestory intValue]];
}

@end
