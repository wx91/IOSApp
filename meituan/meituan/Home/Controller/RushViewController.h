//
//  RushViewController.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RushViewController : UIViewController<UIWebViewDelegate>{
    UILabel *_titleLabel;
    
    UIActivityIndicatorView *_activityView;
}

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSString *urlStr;

@end
