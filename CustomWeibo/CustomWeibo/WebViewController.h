//
//  WebViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/11.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>{
    NSString *_url;
}
@property(nonatomic,strong) IBOutlet UIWebView *webView;

- (IBAction)goBack:(id)sender;
- (IBAction)refresh:(id)sender;
- (IBAction)goForward:(id)sender;

- (instancetype)initWithURL:(NSString *)url;

@end
