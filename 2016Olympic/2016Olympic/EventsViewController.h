//
//  EventsViewController.h
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsBL.h"
#import "Events.h"
#import "EventsDetailViewController.h"

@interface EventsViewController : UITableViewController

@property(strong,nonatomic)NSArray *events;

@end
