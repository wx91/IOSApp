//
//  JZOnSiteViewController.h
//  meituan
//
//  Created by jinzelu on 15/7/9.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeServiceCell.h"

@interface JZOnSiteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HomeServiceDelegate>{
    NSMutableArray *_advArray;//广告数据源
    NSMutableArray *_advImageUrlArray;//广告图片数组
    NSMutableArray *_homeServiceArray;//上门服务数据源
    
}

@property(nonatomic, strong) UITableView *tableView;

@end
