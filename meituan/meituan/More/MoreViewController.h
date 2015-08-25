//
//  MoreViewController.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *data;
}

@property(nonatomic,strong)UITableView *tableView;

@end
