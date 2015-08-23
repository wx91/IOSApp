//
//  JZMerchantDetailViewController.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMerchantDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UILabel *_titleLabel;
    NSMutableArray *_dataSourceArray;
    NSMutableArray *_dealsArray;//附近团购数组
}
//商店ID
@property(nonatomic, strong) NSString *poiid;

@property(nonatomic, strong) UITableView *tableView;

@end
