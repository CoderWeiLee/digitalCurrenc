//
//  AccountSettingTableViewCell.m
//  digitalCurrency
//
//  Created by iDog on 2019/1/29.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "AccountSettingTableViewCell.h"

@implementation AccountSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftLabel.font = [UIFont systemFontOfSize:16 * kWindowWHOne];
    self.rightLabel.font = [UIFont systemFontOfSize:16 * kWindowWHOne];
    self.leftLabel.textColor = AppTextColor_Level_1;
    self.rightLabel.textColor = AppTextColor_Level_2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
