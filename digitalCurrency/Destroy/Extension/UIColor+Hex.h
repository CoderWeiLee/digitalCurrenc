//
//  UIColor+Hex.h
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)
+ (instancetype)colorWithHexString:(NSString *)color;
+ (instancetype)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
