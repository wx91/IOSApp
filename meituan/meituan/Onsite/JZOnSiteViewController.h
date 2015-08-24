//
//  JZOnSiteViewController.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeServiceModel.h"
#import "HomeServiceCell.h"

@interface JZOnSiteViewController : UITableViewController<HomeServiceDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_advArray;//广告数据源
    NSMutableArray *_advImageUrlArray;//广告图片数组
    NSMutableArray *_homeServiceArray;//上门服务数据源
}

//@property(strong,nonatomic)UITableView *tableView;


@end
