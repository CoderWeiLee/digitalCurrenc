//
//  AactionCollectionViewCell.m
//  digitalCurrency
//
//  Created by startlink on 2019/8/6.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "AactionCollectionViewCell.h"

@implementation AactionCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = mainColor;
    self.namelabel.textColor = AppTextColor_Level_2;
}

@end
