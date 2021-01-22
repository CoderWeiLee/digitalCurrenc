//
//  HelpCenterDetailsViewController.m
//  digitalCurrency
//
//  Created by chu on 2019/8/10.
//  Copyright © 2019年 ABC. All rights reserved.
//

#import "HelpCenterDetailsViewController.h"
#import <WebKit/WebKit.h>

@interface HelpCenterDetailsViewController ()<WKNavigationDelegate>
{
    NSString *_title;
    NSString *_source;
    NSString *_content;

    WKWebView *_webView;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HelpCenterDetailsViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebView *web =[[WKWebView alloc] init];
    web.navigationDelegate = self;
    web.backgroundColor = [UIColor clearColor];
    web.opaque = NO;
    web.scrollView.scrollEnabled = true;
    _webView = web;
    [self loadScrollView];
    [self initData];
}



- (void)loadScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH - NEW_NavHeight)];
    self.scrollView.contentSize = CGSizeMake(kWindowW, kWindowH - NEW_NavHeight);
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled = false;
}

- (void)loadSubViews{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kWindowW - 30, 0)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:23];
    label.text = _title;
    CGSize maxSize = CGSizeMake(kWindowW - 30, MAXFLOAT);
    CGSize a = [label sizeThatFits:maxSize];
    label.frame = CGRectMake(15, 15, kWindowW - 30, a.height);
    label.textColor = AppTextColor_Level_1;
    [self.scrollView addSubview:label];

    UILabel *source = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame) + 10, kWindowW - 30, 15)];
    source.text = _source;
    source.textAlignment = NSTextAlignmentCenter;
    source.font = [UIFont systemFontOfSize:13];
    source.textColor = RGBOF(0x999999);
    [self.scrollView addSubview:source];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(source.frame) + 8, kWindowW - 30, 1)];
    lineView.backgroundColor = RGBOF(0x333333);
    [self.scrollView addSubview:lineView];

    _webView.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame), kWindowW, kWindowH - NEW_NavHeight - CGRectGetMaxY(lineView.frame));

    [self.scrollView addSubview:_webView];
}

- (void)initData{
    _title = self.contentModel.title;
    NSString *time = self.contentModel.createTime;
    _source = [NSString stringWithFormat:@"%@  ABC交易所",time];
    _content = self.contentModel.content;

    NSString *htmlStr = [NSString stringWithFormat:@"<head><style>img{max-width:%dpx !important;}</style></head>%@",(int)(kWindowW - 20), _content];
    [_webView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:HOST]];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self loadSubViews];

    NSString *str = [NSString stringWithFormat:@"var script = document.createElement('script');"
                     "script.type = 'text/javascript';"
                     "script.text = \"function ResizeImages() { "
                     "var myimg,oldwidth,oldheight;"
                     "var maxwidth=%f;"// 图片宽度
                     "for(i=0;i <document.images.length;i++){"
                     "myimg = document.images[i];"
                     "if(myimg.width > maxwidth){"
                     "myimg.width = maxwidth;"
                     "}"
                     "}"
                     "}\";"
                     "document.getElementsByTagName('head')[0].appendChild(script);",(kWindowW - 20)];
    

    [webView evaluateJavaScript:str completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
    
    [webView evaluateJavaScript:@"ResizeImages();" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
    //方法1
    //HTML5的高度
    __block NSString *htmlHeight = @"0";
    
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",response);
        htmlHeight = response;
    }];
    __block NSString *htmlWidth = @"0";
    //HTML5的宽度
    [webView evaluateJavaScript:@"document.body.scrollWidth" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",response);
        htmlWidth = response;
    }];
    
    //宽高比
    float i = [htmlWidth floatValue]/[htmlHeight floatValue];

    //webview控件的最终高度
    float height = kWindowW/i;

    CGRect frame = _webView.frame;
//    _webView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height + 10);
    self.scrollView.contentSize = CGSizeMake(kWindowW, CGRectGetMaxY(_webView.frame));
}

@end
