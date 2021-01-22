//
//  PlatformMessageDetailViewController.m
//  digitalCurrency
//
//  Created by iDog on 2019/3/21.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "PlatformMessageDetailViewController.h"
#import <WebKit/WebKit.h>
#import "DCProject-Swift.h"

@interface PlatformMessageDetailViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation PlatformMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navtitle;
//    self.title = LocalizationKey(@"notice");
    [self.view addSubview:[self webView]];
    // Do any additional setup after loading the view.
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH-NEW_NavHeight)];
        _webView.navigationDelegate = self;
//        NSString *hostString = [HOST stringByAppendingString: _urlString];
//        NSURL *url = [NSURL URLWithString: hostString];
        [self loadHTMLStringWithMagic: self.content];
//        [_webView loadHTMLString: self.content baseURL: nil];
        _webView.opaque = NO;
        _webView.backgroundColor = mainColor;
    }
    return _webView;
}

-(void) loadHTMLStringWithMagic: (NSString *) string {
    NSString * headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    [_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",headerString,string] baseURL:nil];
}

#pragma mark - WKNavigationDelegate

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    NSURLResponse * response = navigationResponse.response;
//
//    NSLog(@"reponse = %@", response)
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
//
//-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSURLRequest * request =   navigationAction.request;
//    NSMutableURLRequest * mutRequest = [request mutableCopy];
//    NSDictionary * dictHader = request.allHTTPHeaderFields;
//    if ([dictHader objectForKey:@"new-access-auth-token"]) {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    } else {
//        [mutRequest setValue:@"newValue" forHTTPHeaderField:@"new-access-auth-token"];        [webView loadRequest:mutRequest];
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//}
- (void)webView:(WKWebView *)webView authenticationChallenge:(NSURLAuthenticationChallenge *)challenge shouldAllowDeprecatedTLS:(void (^)(BOOL))decisionHandler {
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [EasyShowLodingView showLodingText:LocalizationKey(@"loading")];
}
 
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
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
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
    
    
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [EasyShowLodingView hidenLoding];
}
 
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [EasyShowLodingView hidenLoding];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
