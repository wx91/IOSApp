//
//  HomeViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/9.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboSDK.h"
#import "WeiboTableView.h"
#import "ThemeImageView.h"

@interface HomeViewController : BaseViewController<WBHttpRequestDelegate,UITableViewEventDelegate>{
    ThemeImageView *barView;    //显示刷新多少条view
}
//本次获取的按时间最早的微博ID
@property (nonatomic,copy)NSString *topWeiboId;
//本次获取的按时间最晚的微博ID
@property (nonatomic,copy)NSString *lastWeiboId;
//存储微博数据
@property (nonatomic,retain)NSMutableArray *weibos;
//自定义的微博tableview
@property (nonatomic,retain)WeiboTableView *tableView;
//微博发起请求类
@property (nonatomic ,strong)WBAuthorizeRequest *request;
//刷新微博
- (void)refreshWeibo;
//获取weibo的令牌等
- (void)Get;
@end
