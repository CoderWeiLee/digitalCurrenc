//
//  addminecell.h
//  digitalCurrenc
//
//  Created by work on 2020/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface addminecell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *backview;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *bindMa;


@property (nonatomic,copy) void (^selectBlock)(NSInteger num);

@end

NS_ASSUME_NONNULL_END
