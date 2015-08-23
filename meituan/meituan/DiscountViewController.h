//
//  DiscountViewController.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountViewController : UIViewController<UIWebViewDelegate>{
    
    UILabel *_titleLabel;
    
    UIActivityIndicatorView *_activityView;
}

/**
 *  webview加载的url
 */
@property(nonatomic, strong) NSString *urlStr;

@property(nonatomic, strong) UIWebView *webView;

@end
