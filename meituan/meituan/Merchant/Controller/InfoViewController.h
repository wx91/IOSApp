//
//  InfoViewController.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMenuCell.h"

@interface InfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, JZMenuCellDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end
