//
//  FFSaveMnemonicCell.m
//  FlowerFire
//
//  Created by 王涛 on 2020/8/25.
//  Copyright © 2020 Celery. All rights reserved.
//

#import "FFSaveMnemonicCell.h"

@implementation FFSaveMnemonicCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [[WTLabel alloc] initWithFrame:CGRectMake(self.width * 0.15, self.height * 0.15, self.width * 0.7, self.height * 0.7)];
        self.title.font = tFont(14);
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.textColor = KBlackColor;
        self.title.layer.cornerRadius = self.height * 0.7 * 0.5;
        [self.contentView addSubview:self.title];
    }
    return self;
}

@end
