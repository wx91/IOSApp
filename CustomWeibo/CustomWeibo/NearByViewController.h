//
//  NearByViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/13.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

typedef void(^SelectDoneBlock)(NSDictionary *);

@interface NearByViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,WBHttpRequestDelegate>{
        UILabel *headerLabel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong) CLLocationManager *locationManager;

@property(nonatomic,retain) NSArray *data;

@property (nonatomic,copy)SelectDoneBlock selectBlock;

@end
