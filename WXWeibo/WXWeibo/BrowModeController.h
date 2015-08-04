//
//  BrowModeController.h
//  WXWeibo
//
//  Created by wangx on 15/8/4.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"

@interface BrowModeController : BaseViewController<UITableViewDelegate,UITableViewDataSource>


@property(retain ,nonatomic)IBOutlet UITableView *tableView;

@end
