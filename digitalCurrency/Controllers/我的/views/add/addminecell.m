//
//  addminecell.m
//  digitalCurrenc
//
//  Created by work on 2020/11/19.
//

#import "addminecell.h"
#import "AactionCollectionViewCell.h"

@implementation addminecell

-  (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = mainColor;
    self.backview.layer.masksToBounds = YES;
    self.backview.layer.cornerRadius = 3;
    self.titlelabel.text = LocalizationKey(@"minefuck2");
    [self updatacollectionUI];
    // minefuck1
}

-(void)updatacollectionUI{
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerNib:[UINib nibWithNibName:@"AactionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AactionCollectionViewCell"];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 4;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AactionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AactionCollectionViewCell" forIndexPath:indexPath];

    // 我的推广 合伙级别  收款设置 复制链接
    
    NSArray *namearray = @[LocalizationKey(@"wwwwwww1"),LocalizationKey(@"wwwwwww2"),LocalizationKey(@"wwwwwww3"),LocalizationKey(@"wwwwwww4")];
    NSArray *imagearray = @[@"我的推广",@"",@"收款设置",@"复制链接"];
    cell.logimage.image = [UIImage imageNamed:imagearray[indexPath.row]];
    cell.namelabel.text = namearray[indexPath.row];
    cell.namelabel.textColor = AppTextColor_Level_1;
    
    if (indexPath.row == 1) {
        self.label = [[UILabel alloc]init];
        self.label.frame = cell.logimage.bounds;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.text = @"L0";//230 147 36
        self.label.textColor = [UIColor colorWithRed:230/255.0 green:147/255.0 blue:36/255.0 alpha:1.0];
        [cell.logimage addSubview:self.label];
    }
    return cell;


}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.collectionview.width / 4,self.collectionview.width / 4 + 10);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    self.selectBlock(indexPath.row);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)bindMa:(id)sender {
    
    self.selectBlock(1000);
}

@end
