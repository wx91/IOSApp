//
//  UserViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/12.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"
#import "UserInfoView.h"

@interface UserViewController : BaseViewController<WBHttpRequestDelegate,UITableViewEventDelegate>

@property (strong, nonatomic) IBOutlet WeiboTableView *tableView;


@property (nonatomic,copy)NSString *topWeiboId;
@property (nonatomic,copy)NSString *lastWeiboId;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *userid;

@property (nonatomic,assign)BOOL showLoginUser;
@property (nonatomic,copy)UserInfoView *userInfoView;
@property (nonatomic,retain)NSMutableArray *weibos;

@end
