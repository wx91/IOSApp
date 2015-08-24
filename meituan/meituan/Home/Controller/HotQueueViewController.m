//
//  HotQueueViewController.m
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "HotQueueViewController.h"
#import "Constant.h"

@implementation HotQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed=YES;
    _isFirstIn=0;
    
}
#pragma mark 设置页面的导航栏
-(void)setNav{
    //背景栏
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0,0, screen_width, 64)];
    backView.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:backView];
    //下划线
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 63.5, screen_width, 0.5)];
    lineView.backgroundColor = RGB(192, 192, 192);
    [backView addSubview:lineView];
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 30, 23, 23);
    [backBtn setImage:[UIImage imageNamed:@"btn_backItem"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-80, 30, 160, 30)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //    _titleLabel.textColor = [UIColor whiteColor];
    [backView addSubview:_titleLabel];
}

#pragma mark 初始化页面信息
-(void)initViews{
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
    NSLog(@"webview URL:%@",self.urlStr);
    NSString *urlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(screen_width/2-15, screen_height/2-15, 30, 30)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityView.hidesWhenStopped = YES;
    [self.view addSubview:_activityView];
    [self.view bringSubviewToFront:_activityView];
}
#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载webview");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载webview完成");
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    _titleLabel.text = theTitle;
    self.title = theTitle;
    [_activityView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载webview失败");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [_activityView startAnimating];
    _isFirstIn++;
    NSLog(@"In:%d",_isFirstIn);
    return YES;
}

#pragma mark - 响应事件
-(void)OnBackBtn:(UIButton *)sender{
    NSLog(@"_isFirstIn:%d",_isFirstIn);
    if (_isFirstIn <= 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        _isFirstIn = _isFirstIn - 2;
        [self.webView goBack];
    }
}

#pragma mark System Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
