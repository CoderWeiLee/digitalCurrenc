//
//  FFSaveMnemonicViewController.m
//  FlowerFire
//
//  Created by 王涛 on 2020/8/25.
//  Copyright © 2020 Celery. All rights reserved.
//  保存助记词

#import "FFSaveMnemonicViewController.h"
#import "FFSaveMnemonicCell.h"
#import "FFVerificationMnemonicViewController.h"
#import "AESCipher.h"
#import "WTButton.h"


@interface FFSaveMnemonicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    WTLabel *_tip,*_tip2;
}
@property(nonatomic, strong)UICollectionView *collectionView;




@end

@implementation FFSaveMnemonicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBar];
    [self initData];
    [self createUI];
    
}

- (void)createNavBar{
//    self.gk_navigationItem.title = LocalizationKey(@"578Tip100");
}

- (void)createUI{
    self.view.backgroundColor = [UIColor blackColor];
    _tip = [[WTLabel alloc]  initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, Height_NavBar + 10, ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 60) Text:LocalizationKey(@"578Tip101") Font:tFont(15)  textColor:KBlackColor parentView:self.view];
    _tip.numberOfLines = 2;
    _tip.textColor = [UIColor whiteColor];
     
    UICollectionViewFlowLayout *ufl = [[UICollectionViewFlowLayout alloc] init];
    ufl.minimumLineSpacing = 0;
    ufl.minimumInteritemSpacing = 0;
    ufl.itemSize = CGSizeMake((ScreenWidth - 2 * OverAllLeft_OR_RightSpace)/3, 45);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, _tip.bottom + 20, ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 45 * self.dataArray.count/3) collectionViewLayout:ufl];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = RGB(30, 30, 30);
    self.collectionView.layer.cornerRadius = 5;
    [self.view  addSubview:self.collectionView];
     
    _tip2 = [[WTLabel alloc]  initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, self.collectionView.bottom + 20, ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 100) Text:LocalizationKey(@"578Tip102") Font:tFont(15)  textColor:grayTextColor parentView:self.view];
    _tip2.numberOfLines = 0;
    _tip2.textColor = RGB(153, 153, 153);
    
    WTButton *nextButton = [[WTButton alloc] initWithFrame:CGRectMake(OverAllLeft_OR_RightSpace, _tip2.bottom + 30, ScreenWidth - 2 * OverAllLeft_OR_RightSpace, 45) titleStr:LocalizationKey(@"578Tip104") titleFont:tFont(15) titleColor:KWhiteColor parentView:self.view];
    nextButton.layer.cornerRadius = 2;
    nextButton.backgroundColor = [UIColor orangeColor];
    
    [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    UIButton *backButton = [[UIButton alloc] init];
    backButton.frame = CGRectMake(20, 40, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"back_bbbb"] forState:UIControlStateNormal];
//    backButton.backgroundColor = [UIColor redColor];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:backButton];
    
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



- (void)next{
    
    FFVerificationMnemonicViewController *fvc = [FFVerificationMnemonicViewController new];
    fvc.registeredParamsModel = self.registeredParamsModel;
    fvc.dataArray = [self sortedRandomArrayByArray:self.dataArray].mutableCopy;
    [self.navigationController pushViewController:fvc animated:YES];
    
}

- (void)initData{
    NSString *mnemonic = aesDecryptString(self.registeredParamsModel.mnemonic, AES_KEY);
    self.dataArray = [mnemonic componentsSeparatedByString:@" "].copy;
    
    [self.collectionView reloadData];
}

#pragma mark - collectionViewDelegate
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    [self.collectionView registerClass:[FFSaveMnemonicCell class] forCellWithReuseIdentifier:identifier];
    FFSaveMnemonicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(self.dataArray.count>0){
        cell.title.text = self.dataArray[indexPath.row];
        cell.title.textColor = [UIColor orangeColor];
        cell.title.layer.borderWidth = 1;
        cell.title.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//对数组随机排序
- (NSArray *)sortedRandomArrayByArray:(NSMutableArray *)array{

    NSArray *randomArray = [[NSArray alloc]init];
    randomArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];

    return randomArray;
}


@end
