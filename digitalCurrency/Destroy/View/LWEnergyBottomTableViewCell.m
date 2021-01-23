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
