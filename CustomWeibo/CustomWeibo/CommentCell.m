//
//  CommentCell.m
//  CustomWeibo
//
//  Created by wangx on 15/8/11.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+URLEncoding.h"
#import "UIUtils.h"
#import "UIViewExt.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)initView {
    _userImageView=[[UIImageView alloc]initWithFrame:CGRectZero];
    _userImageView.backgroundColor=[UIColor clearColor];
    _userImageView.layer.cornerRadius=5;
    _userImageView.layer.borderColor=[UIColor grayColor].CGColor;
    _userImageView.layer.masksToBounds=YES;
    
    _nickLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    
    _contentLabel =[[RTLabel alloc]initWithFrame:CGRectZero];
    _contentLabel.font=[UIFont systemFontOfSize:15.0f];
    _contentLabel.delegate=self;
    
    //超链接颜色
    _contentLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    //高亮颜色
    _contentLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    
    [self.contentView addSubview:_contentLabel];
}
-(void)layoutSubviews{
    [self layoutSubviews];
    _userImageView.frame = CGRectMake(10, 10, 30, 30);
    NSString *urlString = self.commentModel.user.profile_image_url;
    if (urlString != nil) {
        [_userImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }
    
    _nickLabel.text = self.commentModel.user.screen_name;
    
    NSString *createDate = self.commentModel.createDate;
    NSString *dateString = [UIUtils fomateString:createDate];
    _timeLabel.text = dateString;
    
    _contentLabel.frame = CGRectMake(_userImageView.right + 10, _nickLabel.bottom + 5, 240, 21);
    NSString *commentText = self.commentModel.text;
    
    //正则表达式解析评论内容
    commentText = [UIUtils parseLink:commentText];
    _contentLabel.text = commentText;
    _contentLabel.height = _contentLabel.size.height + 1;
}
+(float)getCommentHeight:(Comment *)commentModel{
    RTLabel *rt = [[RTLabel alloc]initWithFrame:CGRectMake(0, 0, 240, 0)];
    rt.font = [UIFont systemFontOfSize:14.0f];
    rt.text = commentModel.text;
    return rt.optimumSize.height+3;
}

#pragma mark - RTLabel delegate
//点击高亮字体后的动作


@end
