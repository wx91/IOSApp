//
//  CommentCell.m
//  WXWeibo
//
//  Created by wangx on 15/8/4.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "CommentCell.h"
#import "UIViewExt.h"
#import "UIUtils.h"
@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    _userImage =[(UIImageView *) [self viewWithTag:100] retain];
    _nickLabel=[(UILabel *)[self viewWithTag:101]retain];
    _timeLabel =[(UILabel *)[self viewWithTag:102]retain];
    
    _contentLabel=[[RTLabel alloc]initWithFrame:CGRectZero];
    _contentLabel.font=[UIFont systemFontOfSize:14.0f];
    _contentLabel.delegate=self;
    //设置链接颜色
    _contentLabel.linkAttributes=[NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    _contentLabel.selectedLinkAttributes=[NSDictionary dictionaryWithObject:@"green" forKey:@"color"];
    [self.contentView addSubview:_contentLabel];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSString *urlstring=self.commentModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:urlstring]];
    
    _nickLabel.text=self.commentModel.user.screen_name;
    _nickLabel.text=[UIUtils fomateString:self.commentModel.created_at];
    
    
    _contentLabel.frame=CGRectMake(_userImage.right+10, _nickLabel.bottom+5, 240, 21);
    NSString *commontText=self.commentModel.text;
    commontText=[UIUtils parseLink:commontText];
    _contentLabel.text=commontText;
    _contentLabel.height=_contentLabel.optimumSize.height;
    
    
    
}

+(float)getCommentHeight:(CommentModel *)commentModel{
    RTLabel *rt=[[RTLabel alloc]initWithFrame:CGRectMake(0, 0, 240, 0)];
    rt.font=[UIFont systemFontOfSize:14.0f];
    rt.text=commentModel.text;
    return rt.optimumSize.height;
}

#pragma mark - RTLabel delegate
-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url{
    
}

@end
