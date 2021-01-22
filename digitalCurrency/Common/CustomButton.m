//
//  CustomButton.m
//  gt-captcha3-ios-example
//
//  Created by NikoXu on 08/04/2017.
//  Copyright © 2017 Xniko. All rights reserved.
//

#import "CustomButton.h"
#import "DemoAyncTask.h"

//网站主部署的用于验证初始化的接口 (api_1)
#define api_1 [NSString stringWithFormat:@"%@%@",HOST,@"uc/start/captcha"]


//网站主部署的用于验证注册的接口 (api_1)
//#define api_1 @"http://www.geetest.com/demo/gt/register-click"
//网站主部署的二次验证的接口 (api_2)
//#define api_2 @"http://www.geetest.com/demo/gt/validate-click"

@interface CustomButton ()<GT3CaptchaManagerDelegate,GT3CaptchaManagerViewDelegate,DemoAyncTaskDelegate>
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) GT3CaptchaManager *manager;



@end

@implementation CustomButton


- (GT3CaptchaManager *)manager {
    if (!_manager) {
        _manager = [[GT3CaptchaManager alloc] initWithAPI1:api_1 API2:nil timeout:5.0];
        _manager.delegate=self;
        _manager.viewDelegate = self;
     //   [_manager useVisualViewWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];

    }
    return _manager;
}


-(void)setOriginaStyle{
    [self _init];
    [self addTarget:self action:@selector(startCaptcha) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)_init {
    self.indicatorView = [self createActivityIndicator];
    // 必须调用, 用于注册获取验证初始化数据
    
    DemoAyncTask *asyncTask = [[DemoAyncTask alloc] init];
    asyncTask.delegate = self;
    
    [self.manager registerCaptchaWithCustomAsyncTask:asyncTask completion:nil];
   // [self.manager registerCaptcha:nil];
    [self.manager disableBackgroundUserInteraction:YES];
}

- (UIActivityIndicatorView *)createActivityIndicator {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setHidesWhenStopped:YES];
    [indicatorView stopAnimating];
    
    return indicatorView;
}

- (void)startCaptcha {
    
   
    if (_delegate && [_delegate respondsToSelector:@selector(captchaButtonShouldBeginTapAction:)]) {
        if (![_delegate captchaButtonShouldBeginTapAction:self]) {
          //  return;
        }
    }
      [self.manager startGTCaptchaWithAnimated:YES];
}

- (void)stopCaptcha {
   
    [self.manager stopGTCaptcha];
}

- (void)showIndicator {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setUserInteractionEnabled:NO];
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.indicatorView];
        [self centerActivityIndicatorInButton];
        [self.indicatorView startAnimating];
    });
}

- (void)removeIndicator {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setUserInteractionEnabled:YES];
        [self.indicatorView removeFromSuperview];
    });
}

- (void)centerActivityIndicatorInButton {
    NSLayoutConstraint *constraintX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.indicatorView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *constraintY = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.indicatorView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self addConstraints:@[constraintX, constraintY]];
}

#pragma mark GT3CaptchaManagerDelegate

- (void)gtCaptcha:(GT3CaptchaManager *)manager didReceiveSecondaryCaptchaData:(NSData *)data response:(NSURLResponse *)response error:(GT3Error *)error decisionHandler:(void (^)(GT3SecondaryCaptchaPolicy))decisionHandler {
    if (!error) {
        //处理你的验证结果
        NSLog(@"\ndata: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        //成功请调用decisionHandler(GT3SecondaryCaptchaPolicyAllow)
        decisionHandler(GT3SecondaryCaptchaPolicyAllow);
        //失败请调用decisionHandler(GT3SecondaryCaptchaPolicyForbidden)
        //decisionHandler(GT3SecondaryCaptchaPolicyForbidden);
        
    }
    else {
        //二次验证发生错误
        decisionHandler(GT3SecondaryCaptchaPolicyForbidden);
    }
//    if (_delegate && [_delegate respondsToSelector:@selector(captcha:didReceiveSecondaryCaptchaData:response:error:)]) {
//        [_delegate captcha:manager didReceiveSecondaryCaptchaData:data response:response error:error];
//    }
}

- (void)gtCaptcha:(GT3CaptchaManager *)manager errorHandler:(GT3Error *)error {
    //处理验证中返回的错误
    if (error.code == -999) {
        // 请求被意外中断, 一般由用户进行取消操作导致, 可忽略错误
        [APPLICATION.window makeToast:@"请求被意外中断" duration:1.5 position:CSToastPositionCenter];
    }
    else if (error.code == -10) {
        // 预判断时被封禁, 不会再进行图形验证
        [APPLICATION.window makeToast:@"预判断时被封禁" duration:1.5 position:CSToastPositionCenter];
    }
    else if (error.code == -20) {
        // 尝试过多
        [APPLICATION.window makeToast:@"尝试过多" duration:1.5 position:CSToastPositionCenter];
    }
    else {
        // 网络问题或解析失败, 更多错误码参考开发文档
        [APPLICATION.window makeToast:@"网络问题或解析失败" duration:1.5 position:CSToastPositionCenter];
    }
    
}

- (void)gtCaptchaUserDidCloseGTView:(GT3CaptchaManager *)manager {
    NSLog(@"用户主动关闭了验证码界面");
 
}
/** 修改API1的请求 */
- (void)gtCaptcha:(GT3CaptchaManager *)manager willSendRequestAPI1:(NSURLRequest *)originalRequest withReplacedHandler:(void (^)(NSURLRequest *))replacedHandler {
    NSString *ts = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000];
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:@"t" value:ts];
    NSURLComponents *comp = [NSURLComponents componentsWithURL:originalRequest.URL resolvingAgainstBaseURL:NO];
    comp.queryItems = @[queryItem];

    NSMutableURLRequest *mRequest = [originalRequest mutableCopy];
    mRequest.URL = comp.URL;

    replacedHandler(mRequest);
}
- (void)gtCaptcha:(GT3CaptchaManager *)manager willSendSecondaryCaptchaRequest:(NSURLRequest *)originalRequest withReplacedRequest:(void (^)(NSMutableURLRequest *))replacedRequest {
    /// 如果需要可以修改二次验证向服务器发送的请求
    NSMutableURLRequest *mReuqest = [originalRequest mutableCopy];
    NSData *secodaryData = mReuqest.HTTPBody;
    NSLog(@"data: %@", [[NSString alloc] initWithData:secodaryData encoding:NSUTF8StringEncoding]);
    id jsonObj = [NSJSONSerialization JSONObjectWithData:secodaryData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)jsonObj];
    if (_delegate && [_delegate respondsToSelector:@selector(delegateGtCaptcha: didReceiveCaptchaCode:result: message:)]) {
           [_delegate delegateGtCaptcha:manager didReceiveCaptchaCode:@"0"  result:dic message:@""];
       }
    /**
     TO-DO, 处理secodaryData, 添加业务数据
     */
     
//    NSData *newData = [secodaryData handlerYourData]
//    mReuqest.HTTPMethod = newData;
    replacedRequest(mReuqest);
    
    
}
// 不使用默认的二次验证接口
//
//- (void)gtCaptcha:(GT3CaptchaManager *)manager didReceiveCaptchaCode:(NSString *)code result:(NSDictionary *)result message:(NSString *)message {
//
//    if (_delegate && [_delegate respondsToSelector:@selector(delegateGtCaptcha: didReceiveCaptchaCode:result: message:)]) {
//        [_delegate delegateGtCaptcha:manager didReceiveCaptchaCode:code  result:result message:message];
//    }
//
//}



@end
