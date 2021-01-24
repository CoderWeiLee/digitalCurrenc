//
//  PlatformMessageDetailViewController.m
//  digitalCurrency
//
//  Created by iDog on 2019/3/21.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "wwwwwViewController.h"
#import <Masonry/Masonry.h>
#import "LWDestroyHeaderView.h"
#import <WebKit/WebKit.h>
@interface wwwwwViewController ()<UITableViewDataSource, UITableViewDelegate, WKNavigationDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation wwwwwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"销毁交易";
//    self.tableView = [[UITableView alloc]init];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    [self.tableView registerClass:[LWDestroyHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([LWDestroyHeaderView class])];
    [self.view addSubview:[self webView]];
}




#pragma mark - UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LWDestroyHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([LWDestroyHeaderView class])];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 42;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    
    return cell;
}

-(WKWebView *)webView{
    if (!_webView) {
        NSString*md5Str= [YLUserInfo shareUserInfo].token;

        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH-NEW_NavHeight)];
        _webView.navigationDelegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://device.abc.tm/?token=%@",md5Str]]]];
    }
    return _webView;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [EasyShowLodingView hidenLoding];
    NSString *js=@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth = %f;"
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = %f;"
    "}"
    "}"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    js = [NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-20];
    [webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
    [webView evaluateJavaScript:@"ResizeImages();" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#999999'" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [EasyShowLodingView showLodingText:LocalizationKey(@"aaaaaa")];
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
   [EasyShowLodingView hidenLoding];
}
 
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [EasyShowLodingView hidenLoding];
}
@end
