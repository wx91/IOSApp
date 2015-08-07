//
//  WeiboCell.m
//  WXWeibo
//
//  Created by wangx on 15/7/31.
//  Copyright (c) 2015年 wangx. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "RegexKitLite.h"
#import "WeiboCell.h"
#import "WeiboView.h"
#import "UIViewExt.h"
#import "UIUtils.h"
#import "Constant.h"

@implementation WeiboCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

//初始化子视图
-(void)initView{
    //用户头像
    _userImage=[[UIImageView alloc]initWithFrame:CGRectZero];
    _userImage.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:_userImage];
    
    //昵称
    _nickLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _nickLabel.backgroundColor=[UIColor clearColor];
    _nickLabel.font=[UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_nickLabel];
    
    
    //创建时间
    _createLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _createLabel.font=[UIFont systemFontOfSize:12.0];
    _createLabel.backgroundColor=[UIColor clearColor];
    _createLabel.textColor=[UIColor blueColor];
    [self.contentView addSubview:_createLabel];
    
    //来源
    _sourceLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _sourceLabel.font=[UIFont systemFontOfSize:12.0];
    _sourceLabel.backgroundColor=[UIColor clearColor];
    _sourceLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];
    
    //转发数
    _repostCountLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _repostCountLabel.font=[UIFont systemFontOfSize:12.0];
    _repostCountLabel.backgroundColor=[UIColor clearColor];
    _repostCountLabel.textColor=[UIColor blackColor];
    _repostCountLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_repostCountLabel];
    
    //回复数
    _commentCountLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _commentCountLabel.font=[UIFont systemFontOfSize:12.0];
    _commentCountLabel.backgroundColor=[UIColor clearColor];
    _commentCountLabel.textColor=[UIColor blackColor];
    _commentCountLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_commentCountLabel];
    
    //表态数
    _attitudeCountLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _attitudeCountLabel.font=[UIFont systemFontOfSize:12.0];
    _attitudeCountLabel.backgroundColor=[UIColor clearColor];
    _attitudeCountLabel.textColor=[UIColor blackColor];
    _attitudeCountLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_attitudeCountLabel];
    
    //创建微博
    _weiboView=[[WeiboView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];

}

-(void)layoutSubviews{
    WeiboModel *weibo=_weibo;
    
    _userImage.frame=CGRectMake(5, 5, 40, 40);
    NSString *userImageUrl=weibo.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:userImageUrl]];
    
    _nickLabel.text=weibo.user.screen_name;
    _nickLabel.frame=CGRectMake(_userImage.right+5, _userImage.top, 200, 20);
    
    
    //源日期字符串 Tue May 31 17:46:55 +0800 2011
    NSString *createDate=weibo.createDate;
    NSString *datestring=[UIUtils fomateString:createDate];
    _createLabel.text=datestring;
    [_createLabel sizeToFit];
    _createLabel.frame=CGRectMake(_userImage.right+5, _nickLabel.bottom, 80, 20);
    
    NSString *source=weibo.source;
    //<a href="http://weibo.com" rel="nofollow">新浪微博<a>
    NSString *ret=[self parseSource:source];
    _sourceLabel.text=[NSString stringWithFormat:@"来自%@",ret];
    [_sourceLabel sizeToFit];
    _sourceLabel.frame=CGRectMake(_createLabel.right+5,_nickLabel.bottom, 100, 20);
    
    NSNumber *resposts=weibo.repostsCount;
    _repostCountLabel.text=[NSString stringWithFormat:@"转发%@",resposts];
    _repostCountLabel.frame=CGRectMake(5,self.height-20,100, 20);
    
    NSNumber *comments=weibo.commentsCount;
    _commentCountLabel.text=[NSString stringWithFormat:@"评论%@",comments];
    _commentCountLabel.frame=CGRectMake(105, self.height-20, 100, 20);
    
    _attitudeCountLabel.frame=CGRectMake(215, self.height-20, 100, 20);
    NSNumber *attitudes=weibo.attitudesCount;
    _attitudeCountLabel.text=[NSString stringWithFormat:@"赞%@",attitudes];
    
    _weiboView.weiboModel=weibo;
    float height=[WeiboView getWeiboViewHeight:weibo isRepost:NO isDetail:NO];
    _weiboView.frame=CGRectMake(50, _userImage.bottom+5, 260, height);
    
}

//-(UIView *)selectedBackgroundView{
//    UIView *selectedBackgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
//    selectedBackgroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"statusdetail_cell_sepatator.png"]];
//    return selectedBackgroundView;
//}

-(NSString *)parseSource:(NSString *)source{
//    NSString *regex=@">\\w+<";
    NSString *regex=@"(>\\w+)|(<\\w+)";
    NSArray *array=[source componentsSeparatedByRegex:regex];
    if (array.count>0) {
        //>新浪微博<
        NSString *ret=[array objectAtIndex:4];
        NSRange range;
        range.location=1;
        range.length=ret.length-1;
        NSString *resultstring=[ret substringWithRange:range];
        return resultstring;
    }
    return nil;
}

@end
