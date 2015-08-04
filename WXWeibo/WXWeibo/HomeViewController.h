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
    ThemeImageView *barView;
}

@property(nonatomic,retain)  WeiboTableView *tableView;

@property(nonatomic,copy) NSString *topWeiboId;

@property(nonatomic,copy)NSString *lastWeiboId;

@property(nonatomic,retain)NSMutableArray *weibos;


-(void)refreshWeibo;
@end
