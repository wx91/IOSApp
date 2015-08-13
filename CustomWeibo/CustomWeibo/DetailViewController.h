//
//  DetailViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/11.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBHttpRequest.h"
#import "WeiboView.h"
#import "CommentTableView.h"
#import "ZFModalTransitionAnimator.h"

@interface DetailViewController : UIViewController<WBHttpRequestDelegate,UITableViewEventDelegate>{
    WeiboView *_weiboView;
}

@property (nonatomic,copy   ) NSString                  *lastWeiboID;

@property (nonatomic,retain ) NSMutableArray            *comments;

@property (nonatomic,strong ) IBOutlet CommentTableView *tableView;

@property (strong, nonatomic) UIImageView               *userImageView;

@property (strong, nonatomic) UILabel                   *nickLabel;

@property (strong,nonatomic ) UILabel                   *timeLabel;

@property (nonatomic,retain ) Status                    *weiboModel;

@property (nonatomic, strong) ZFModalTransitionAnimator *animator;

-(void)loadData;


@end
