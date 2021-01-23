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
@property (nonatomic, strong) UILabel *openSourceAmountLabel;

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
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
