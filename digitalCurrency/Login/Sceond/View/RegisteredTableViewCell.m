//
//  RegisteredTableViewCell.m
//  FlowerFire
//
//  Created by 王涛 on 2020/5/14.
//  Copyright © 2020 Celery. All rights reserved.
//

#import "RegisteredTableViewCell.h"

@interface RegisteredTableViewCell ()
{
    
}
@end

@implementation RegisteredTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self createUI];
        [self layoutSubview];
    }
    return self;
}

- (void)createUI{
    _textField = [[RegisteredTextField alloc] initWithFrame:CGRectMake(40, 0, ScreenWidth - 2 * 40, 50) titleStr:@"1" placeholderStr:@"1"];
    _textField.line.backgroundColor = RGB(30, 30, 30);
    _textField.title.textColor = [UIColor whiteColor];
    _textField.rightButton.titleLabel.font = tFont(15);
 
    [self addSubview:_textField];
}

- (void)layoutSubview{
    [super layoutSubviews];
    self.backgroundColor = [UIColor blackColor];
}

- (void)setCellData:(NSDictionary *)dic{
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:LocalizationKey(dic[@"details"]) attributes:
        @{NSForegroundColorAttributeName:RGB(132, 132, 132)
             }];

    
    _textField.loginInputView.attributedPlaceholder = attrString;
    _textField.loginInputView.textColor = [UIColor whiteColor];
    _textField.loginInputView.text = dic[@"title"];
    
   if([[dic allKeys] containsObject:@"rightBtnTitle"]){
        [_textField.rightButton setTitle:LocalizationKey(dic[@"rightBtnTitle"]) forState:UIControlStateNormal];
        _textField.rightView.width = 130;
//        [_textField.rightButton theme_setTitleColor:THEME_TEXT_COLOR forState:UIControlStateNormal]; 
        _textField.rightButton.width = 130;
    }
    
}

@end
