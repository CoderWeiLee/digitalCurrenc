//
//  LWRealNameTableViewCell.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/7.
//

#import "LWRealNameTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWRealNameTableViewCell()
@property (nonatomic, strong) UILabel *realNameLabel;
@property (nonatomic, strong) UILabel *ipAddressLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation LWRealNameTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.realNameLabel = [[UILabel alloc] init];
        self.realNameLabel.textColor = [UIColor whiteColor];
        self.realNameLabel.font = [UIFont systemFontOfSize:11];
        self.realNameLabel.layer.cornerRadius = 2;
        self.realNameLabel.layer.masksToBounds = YES;
        self.realNameLabel.backgroundColor = [UIColor colorWithHexString:@"#575757"];
        [self.contentView addSubview:self.realNameLabel];
        [self.realNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(20);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(16);
        }];
        
        self.ipAddressLabel = [[UILabel alloc] init];
        self.ipAddressLabel.textColor = [UIColor whiteColor];
        self.ipAddressLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.ipAddressLabel];
        [self.ipAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.realNameLabel.mas_right).offset(8);
            make.top.mas_equalTo(self.realNameLabel).offset(2.5);
        }];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:11];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-20.5);
            make.centerY.mas_equalTo(self.ipAddressLabel);
        }];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"#1E1E1E"];
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(20);
            make.right.mas_equalTo(self.contentView).offset(-20);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

//如果是已实名 #F88D02

@end
