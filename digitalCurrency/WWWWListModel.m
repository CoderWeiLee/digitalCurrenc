//
//  WWWWListModel.m
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/31.
//

#import "WWWWListModel.h"
#import <MJExtension/MJExtension.h>
@implementation WWWWListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}
@end
