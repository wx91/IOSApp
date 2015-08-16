//
//  ScheduleViewController.h
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "ScheduleBL.h"


@interface ScheduleViewController : UITableViewController
//表视图使用的数据
@property(strong,nonatomic)NSDictionary *data;
//比赛日期列表
@property(strong,nonatomic)NSArray *arrayGameDateList;

@end
