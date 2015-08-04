//
//  BaseTableView.h
//  WXWeibo
//
//  Created by wangx on 15/8/1.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
@class BaseTableView;
@protocol UITableViewEventDelegate <NSObject>
@optional
//下拉调用方法
-(void)pullDown:(BaseTableView *)tableView;
//上拉
-(void)pullUp:(BaseTableView *)tableView;
//选中一个cell
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseTableView : UITableView<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    UIButton *_moreButton;
      
}
//是否需要下拉效果
@property(nonatomic,assign)BOOL refreshHeader;
//为tableview提供数据
@property(nonatomic,retain)NSArray *data;

@property(nonatomic,assign)id<UItableviewEventDelegate> eventDelegate;

@property(nonatomic,assign)BOOL isMore;         //是否还有更多(下一页)



- (void)doneLoadingTableViewData;

-(void)refreshData;

@end
