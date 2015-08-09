//
//  HomeViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/9.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboSDK.h"

@interface HomeViewController : BaseViewController<WBHttpRequestDelegate>

@property (nonatomic ,strong)WBAuthorizeRequest *request;

@property (nonatomic,copy)NSString *topWeiboId;

@property (nonatomic,copy)NSString *lastWeiboId;

@property (nonatomic,retain)NSMutableArray *weibos;

@end
