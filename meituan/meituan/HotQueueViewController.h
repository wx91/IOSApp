//
//  HotQueueViewController.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotQueueViewController : UIViewController<UIWebViewDelegate>{
    UILabel *_titleLabel;
    int _isFirstIn;
    UIActivityIndicatorView *_activityView;
}


@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *urlStr;


@end
