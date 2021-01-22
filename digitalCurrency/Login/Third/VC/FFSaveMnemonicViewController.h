//
//  FFSaveMnemonicViewController.h
//  FlowerFire
//
//  Created by 王涛 on 2020/8/25.
//  Copyright © 2020 Celery. All rights reserved.
//

#import "BaseViewController.h"
#import "FFRegisteredParamsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FFSaveMnemonicViewController : BaseViewController

@property(nonatomic, strong)FFRegisteredParamsModel *registeredParamsModel;
@property(strong,nonatomic) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
