//
//  tuiguangTableViewCell.h
//  digitalCurrenc
//
//  Created by work on 2020/11/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface tuiguangTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (nonatomic,copy) void (^BTNBlock)(NSInteger num);



@end

NS_ASSUME_NONNULL_END
