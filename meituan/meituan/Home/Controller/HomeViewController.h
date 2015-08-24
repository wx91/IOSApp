//
//  HomeViewController.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotQueueModel.h"
#import "DiscountCell.h"
#import "RushCell.h"

@interface HomeViewController : UIViewController<DiscountDelegate,RushDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_menuArray;//
    NSMutableArray *_rushArray;
    HotQueueModel *_hotQueueData;
    NSMutableArray *_recommendArray;
    NSMutableArray *_discountArray;
}
@property(nonatomic, strong) UITableView *tableView;

@end
