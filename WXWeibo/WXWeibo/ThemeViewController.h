//
//  ThemeViewController.h
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray *themes;
}
@property(retain ,nonatomic)IBOutlet UITableView *tableView;

@end
