//
//  SettingCenterTableViewCell.m
//  digitalCurrency
//
//  Created by chu on 2019/8/4.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "SettingCenterTableViewCell.h"

@implementation SettingCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rightLabel.textColor = AppTextColor_Level_2;
    self.leftLabel.textColor = AppTextColor_Level_1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
