//
//  FriendsViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendTableView.h"
typedef NS_ENUM(NSInteger, FriendsType) {
    Follows = 100,
    Fans,
};


@interface FriendsViewController : BaseViewController<WBHttpRequestDelegate,UITableViewEventDelegate>

@property(nonatomic,copy)NSString *userName;

@property (nonatomic,retain)NSMutableArray *data;

@property (nonatomic,assign)FriendsType friendType;

@property (nonatomic,copy)NSString *cursor;// 下一页游标

@property (strong, nonatomic) IBOutlet FriendTableView *tableView;

@end
