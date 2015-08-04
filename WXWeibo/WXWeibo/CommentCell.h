//
//  CommentCell.h
//  WXWeibo
//
//  Created by wangx on 15/8/4.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
@interface CommentCell : UITableViewCell<RTLabelDelegate>{
    UIImageView *_userImage;
    UILabel *_nickLabel;
    UILabel *_timeLabel;
    RTLabel *_contentLabel;
}
@property(nonatomic,retain)CommentModel *commentModel;

//计算评论单元格的高度
+(float)getCommentHeight:(CommentModel *)commentModel;

@end
