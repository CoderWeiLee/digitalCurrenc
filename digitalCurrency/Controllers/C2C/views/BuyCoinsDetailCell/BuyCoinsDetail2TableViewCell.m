//
//  BuyCoinsDetail2TableViewCell.m
//  digitalCurrency
//
//  Created by iDog on 2019/2/1.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "BuyCoinsDetail2TableViewCell.h"

@implementation BuyCoinsDetail2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.coinType1Num setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]];
    //38 151 251
    self.coinType1Num.textColor = [UIColor colorWithRed:38.0 / 255.0 green:151.0 / 255.0 blue:251.0 / 255.0 alpha:1.0];
    [self.coinType2Num setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]];
    self.coinType2Num.textColor = [UIColor colorWithRed:38.0 / 255.0 green:151.0 / 255.0 blue:251.0 / 255.0 alpha:1.0];
    self.coinType1Width.constant = (kWindowW-141)/2;
    [self.coinType1Num addTarget:self action:@selector(textfieldAction:) forControlEvents:UIControlEventEditingChanged];
    [self.coinType2Num addTarget:self action:@selector(textfieldAction:) forControlEvents:UIControlEventEditingChanged];
    // Initialization code
}
- (void)textfieldAction:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldTag:TextFieldString:)]) {
        [self.delegate textFieldTag:textField.tag  TextFieldString:textField.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
