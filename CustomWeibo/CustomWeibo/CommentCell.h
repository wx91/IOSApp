//
//  CommentCell.h
//  CustomWeibo
//
//  Created by wangx on 15/8/11.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "Comment.h"
#import "ZFModalTransitionAnimator.h"
#import "RTLabel.h"

@interface CommentCell : UITableViewCell<RTLabelDelegate>{
    UIImageView *_userImageView;
    UILabel     *_nickLabel;
    UILabel     *_timeLabel;
    RTLabel     *_contentLabel;
}

@property(nonatomic,retain)Comment *commentModel;

//计算评论单元格的高度
+(float)getCommentHeight:(Comment *)commentModel;


@end
