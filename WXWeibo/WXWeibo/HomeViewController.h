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
#import "ThemeImageView.h"

@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate,UITableViewEventDelegate>{
    ThemeImageView *_barView;
}

@property(nonatomic,retain) WeiboTableView *tableView;
//获取此次获取的最顶端的微博ID
@property(nonatomic,copy) NSString *topWeiboId;
//获取此次获取的最末端的微博ID
@property(nonatomic,copy)NSString *lastWeiboId;
//获取weibos的内容
@property(nonatomic,retain)NSMutableArray *weibos;
//刷新微博
-(void)refreshWeibo;

@end
