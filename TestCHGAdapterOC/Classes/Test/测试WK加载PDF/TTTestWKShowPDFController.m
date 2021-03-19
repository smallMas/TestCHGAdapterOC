//
//  TTTestWKShowPDFController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/4.
//

#import "TTTestWKShowPDFController.h"
#import <WebKit/WebKit.h>
#import "TTTestAudioViewController.h"

@interface TTTestWKShowPDFController ()
@property (weak, nonatomic) WKWebView *webView;
@property (nonatomic, strong) WKWebViewConfiguration *config;
@end

@implementation TTTestWKShowPDFController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *url = @"https://super-live1.oss-cn-beijing.aliyuncs.com/%E3%80%90Java%E5%BC%80%E5%8F%91%E5%B7%A5%E7%A8%8B%E5%B8%88_%E4%B8%8A%E6%B5%B7%E3%80%91%E4%BD%95%E7%AC%A6%E5%88%9A%205%E5%B9%B4.pdf";
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStyleDone target:self action:@selector(jump)];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.webView reload];
}

- (void)jump {
    TTTestAudioViewController *vc = [TTTestAudioViewController new];
    [self.navigationController pushViewController:vc
                                         animated:NO];
}

- (WKWebView *)webView{
    if (!_webView) {
        WKWebView *obj = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.config];
        obj.navigationDelegate = self;
        obj.UIDelegate = self;
        [self.view addSubview:_webView = obj];
        obj.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        obj.allowsLinkPreview  = NO;// 禁止预览
        obj.scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _webView;
}

- (WKWebViewConfiguration *)config {
    if (!_config) {
        _config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        _config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        _config.preferences.minimumFontSize = 10;
        //是否支持JavaScript
        _config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        _config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        WKUserScript * userScript = [[WKUserScript alloc] initWithSource:@"" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [_config.userContentController addUserScript:userScript];
    }
    return _config;
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s",__FUNCTION__);
}

@end
