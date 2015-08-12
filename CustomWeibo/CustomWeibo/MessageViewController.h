//
//  MessageViewController.h
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"

@interface MessageViewController : BaseViewController<WBHttpRequestDelegate,UITableViewEventDelegate>{
    WeiboTableView *tableView;
}
@end
