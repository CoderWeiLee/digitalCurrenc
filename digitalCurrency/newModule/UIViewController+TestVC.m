//
//  UIViewController+TestVC.m
//  digitalCurrenc
//
//  Created by Munger Yu on 2021/1/5.
//

#import "UIViewController+TestVC.h"
#import "DCProject-Swift.h"

@interface TestVC()
@property (nonatomic,strong)DCConstant *dcCostent;
@end

@implementation TestVC: UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dcCostent = [DCConstant init];
//    [self.dcCostent hello];
}

@end
