//
//  LWEnergyTableViewCell.h
//  digitalCurrenc
//
//  Created by 李伟 on 2021/1/23.
//

#import <UIKit/UIKit.h>
#import "WWWWModel.h"
#import "WWWWListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LWEnergyTableViewCell : UITableViewCell
@property (nonatomic, strong) WWWWModel *model;
@property (nonatomic, strong) WWWWListModel *listModel;
@property (copy) void(^buySuccessBlock)(NSString *msg);
@end

NS_ASSUME_NONNULL_END
