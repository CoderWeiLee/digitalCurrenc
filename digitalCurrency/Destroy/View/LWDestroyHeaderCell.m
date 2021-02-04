//
//  LWDestroyHeaderCell.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/22.
//

#import "LWDestroyHeaderCell.h"
#import <Masonry/Masonry.h>
#define grayBorderColor [UIColor colorWithRed:124.0 / 255.0 green:124.0 / 255.0 blue:124.0 / 255.0 alpha:1]
#define yellowBorderColor [UIColor colorWithRed:248.0 / 255.0 green:141.0 / 255.0 blue:2.0 / 255.0 alpha:1]
@interface LWDestroyHeaderCell()
@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UIButton *enBtn;
@property (nonatomic, strong) UIButton *chBtn;
@end
@implementation LWDestroyHeaderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            self.backgroundColor = [UIColor colorWithRed:16.0 / 255.0 green:16.0 / 255.0 blue:16.0 / 255.0 alpha:1];
            self.logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"destroyLogo"]];
            [self.contentView addSubview:self.logoImgView];
            [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(16.5);
                make.bottom.mas_equalTo(self.contentView);
            }];
    
            self.chBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.chBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8);
            [self.chBtn setTitle:@"中文" forState:UIControlStateNormal];
            self.chBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [self.chBtn setTitleColor:yellowBorderColor forState:UIControlStateNormal];
            self.chBtn.layer.borderWidth = 1;
            self.chBtn.layer.borderColor = yellowBorderColor.CGColor;
            self.chBtn.layer.cornerRadius = 4;
            self.chBtn.layer.masksToBounds = YES;
            [self.contentView addSubview:self.chBtn];
            [self.chBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.bottom.mas_equalTo(self.contentView);
            }];
    
            self.enBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.enBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8);
            [self.enBtn setTitle:@"English" forState:UIControlStateNormal];
            self.enBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [self.chBtn setTitleColor:yellowBorderColor forState:UIControlStateNormal];
            self.enBtn.layer.borderWidth = 1;
            self.enBtn.layer.borderColor = grayBorderColor.CGColor;
            self.enBtn.layer.cornerRadius = 4;
            self.enBtn.layer.masksToBounds = YES;
            [self.contentView addSubview:self.enBtn];
            [self.enBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.chBtn.mas_left).offset(-6.5);
                make.bottom.mas_equalTo(self.contentView);
            }];
    }
    return self;
}

@end
