//
//  CommentTableView.h
//  CustomWeibo
//
//  Created by wangx on 15/8/11.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseTableView.h"

@interface CommentTableView : BaseTableView<UITableViewDelegate>

@property(nonatomic,retain)NSNumber *totalCommentNumber;

@end
