//
//  BaseTableView.h
//  KittenYang
//
//  Created by Kitten Yang on 14-8-4.
//  Copyright (c) 2014年 Kitten Yang. All rights reserved.
//
#import <UIKit/UIKit.h>
@class BaseTableView;
@protocol UITableViewEventDelegate <NSObject>
@optional
//下拉
- (void)pullDown:(BaseTableView *)tableView;
//上拉
- (void)pullUp:(BaseTableView *)tableView;
//选中cell
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface BaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)NSArray *data;        //为tableView提供数据

@property(nonatomic,assign)id<UITableViewEventDelegate> eventDelegate;

@end








