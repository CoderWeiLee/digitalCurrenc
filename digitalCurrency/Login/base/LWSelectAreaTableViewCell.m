//
//  LWSelectAreaTableViewCell.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/6.
//

#import "LWSelectAreaTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@interface LWSelectAreaTableViewCell()
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *codeLabel;
@end
@implementation LWSelectAreaTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.tagLabel = [[UILabel alloc] init];
        self.tagLabel.textColor = [UIColor colorWithHexString:@"#F88D02"];
        self.tagLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.tagLabel];
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(19);
            make.centerY.mas_equalTo(self.contentView).offset(5);
        }];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(71.5);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.codeLabel = [[UILabel alloc] init];
        self.codeLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        self.codeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.codeLabel];
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-35);
        }];
    }
    return self;
}

@end
