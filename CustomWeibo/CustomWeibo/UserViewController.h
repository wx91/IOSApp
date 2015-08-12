//
//  UserViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/12.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"

@interface UserViewController : BaseViewController

@property (weak, nonatomic) IBOutlet WeiboTableView *tableView;

@end
