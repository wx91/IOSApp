//
//  HomeViewController.h
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "WeiboTableView.h"
#import "Constant.h"

@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate,UItableviewEventDelegate>

@property(nonatomic,retain)  WeiboTableView *tableView;

@property(nonatomic,copy) NSString *topWeiboId;

@property(nonatomic,retain)NSMutableArray *weibos;

@end
