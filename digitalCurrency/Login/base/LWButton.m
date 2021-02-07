//
//  LWButton.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/2/7.
//

#import "LWButton.h"

@implementation LWButton

- (void)layoutSubviews {
    [super layoutSubviews];
        CGRect titleF = self.titleLabel.frame;
        CGRect imageF = self.imageView.frame;
        titleF.origin.x = 0;
        self.titleLabel.frame = titleF;
        imageF.origin.x = CGRectGetMaxX(titleF) + 5;
        self.imageView.frame = imageF;
}

@end
