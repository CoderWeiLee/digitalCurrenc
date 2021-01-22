//
//  CustomSectionHeader.h
//  digitalCurrency
//
//  Created by sunliang on 2019/4/11.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSectionHeader : UIView
+(CustomSectionHeader *)instancesectionHeaderViewWithFrame:(CGRect)Rect;
@property (weak, nonatomic) IBOutlet UIButton *morebut;
//@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic,copy)void (^moreBlock)(void);
@end
