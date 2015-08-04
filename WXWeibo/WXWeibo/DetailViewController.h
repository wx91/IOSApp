//
//  DetailViewController.h
//  WXWeibo
//
//  Created by wangx on 15/8/4.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import "CommentTableView.h"

@interface DetailViewController : BaseViewController<UITableViewEventDelegate>{
    WeiboView *_weiboView;
}
@property(nonatomic,retain)WeiboModel *weiboModel;

@property (retain, nonatomic) IBOutlet CommentTableView *tableView;

@property (retain, nonatomic) IBOutlet UIImageView *userImageView;

@property (retain, nonatomic) IBOutlet UILabel *nickLabel;

@property (retain, nonatomic) IBOutlet UIView *userBarView;

@end
