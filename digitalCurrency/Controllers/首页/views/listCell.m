//
//  listCell.m
//  digitalCurrency
//
//  Created by sunliang on 2019/4/14.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "listCell.h"
#import "AppDelegate.h"
@implementation listCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = blackcolor;
    self.contentView.backgroundColor = blackcolor;
    self.titleLabel.textColor = blackcolor;//AppTextColor_Level_1;
  //  self.TradeNum.textColor = AppTextColor_Level_3;
  //  self.CNYlabel.textColor = AppTextColor_Level_3;
}

-(void)configModel:(NSArray*)modelArray withIndex:(int)index{
    symbolModel*model = [modelArray objectAtIndex:index];

    NSDecimalNumber *close = [NSDecimalNumber decimalNumberWithDecimal:[model.close decimalValue]];
    NSDecimalNumber *baseUsdRate = [NSDecimalNumber decimalNumberWithDecimal:[model.baseUsdRate decimalValue]];

    NSArray *array = [model.symbol componentsSeparatedByString:@"/"];
    
    NSMutableAttributedString *attributtes = [[NSMutableAttributedString alloc] initWithString:model.symbol];
    NSRange range = [model.symbol rangeOfString:array.firstObject];
    if (range.location != NSNotFound) {
        NSRange rangePart1 = NSMakeRange(0,range.location);
        NSRange rangePart2 = range;
        NSUInteger rangePart3StartIndex = range.location + range.length;
        NSRange rangePart3 = NSMakeRange(rangePart3StartIndex,model.symbol.length-rangePart3StartIndex);
        
        [attributtes addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, model.symbol.length)];
        [attributtes addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:rangePart1];
        [attributtes addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:rangePart2];
        [attributtes addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:rangePart2];
        [attributtes addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:rangePart3];
    }
    self.titleLabel.attributedText = attributtes;
    
    self.titleIndex.text = [NSString stringWithFormat:@"%d",index+1];
//    self.titleLabel.text = model.symbol;
    self.pricelabel.text = [NSString stringWithFormat:@"%@",[ToolUtil judgeStringForDecimalPlaces:[close stringValue]]];
    self.TradeNum.text = [NSString stringWithFormat:@"%@ %.2f",LocalizationKey(@"hourvol"),model.volume];
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%", model.chg*100];

    if (((AppDelegate*)[UIApplication sharedApplication].delegate).CNYRate) {

        NSDecimalNumber *result = [[close decimalNumberByMultiplyingBy:baseUsdRate] decimalNumberByMultiplyingBy:((AppDelegate*)[UIApplication sharedApplication].delegate).CNYRate];
        NSString *resultStr = [result stringValue];
        if ([resultStr containsString:@"."]) {
            NSArray *arr = [resultStr componentsSeparatedByString:@"."];
            if (arr.count > 1 && [arr[1] length] > 2) {
                resultStr = [NSString stringWithFormat:@"%@.%@",arr[0],[arr[1] substringWithRange:NSMakeRange(0, 2)]];
            }
        }
        self.CNYlabel.text = [NSString stringWithFormat:@"¥ %@",resultStr];
    }
    else {
        self.CNYlabel.text = @"¥ 0.00";
    }
    if (model.change <0) {
        self.pricelabel.textColor = RedColor;
        self.rateLabel.backgroundColor = RedColor;
    }
    else{
        self.pricelabel.textColor = GreenColor;
        self.rateLabel.backgroundColor = GreenColor;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
