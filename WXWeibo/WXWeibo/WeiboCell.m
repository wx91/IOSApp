//
//  WeiboCell.m
//  WXWeibo
//
//  Created by wangx on 15/7/31.
//  Copyright (c) 2015年 wangx. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "WeiboCell.h"
#import "WeiboView.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"
#import "UIUtils.h"
#import "RegexKitLite.h"

@implementation WeiboCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

//初始化子视图
-(void)_initView{
    //用户头像
    _userImage=[[UIImageView alloc]initWithFrame:CGRectZero];
    _userImage.backgroundColor=[UIColor clearColor];
    _userImage.layer.cornerRadius=5;    //圆弧半径
    _userImage.layer.borderWidth=0.5;
    _userImage.layer.borderColor=[UIColor grayColor].CGColor;
    _userImage.layer.masksToBounds=YES;
    [self.contentView addSubview:_userImage];
    
    //昵称
    _nickLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _nickLabel.backgroundColor=[UIColor clearColor];
    _nickLabel.font=[UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nickLabel];
    
    //转发数
    _repostCountLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _repostCountLabel.font=[UIFont systemFontOfSize:12.0];
    _repostCountLabel.backgroundColor=[UIColor clearColor];
    _repostCountLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:_repostCountLabel];
    
    //回复数
    _commentCountLable=[[UILabel alloc]initWithFrame:CGRectZero];
    _commentCountLable.font=[UIFont systemFontOfSize:12.0];
    _commentCountLable.backgroundColor=[UIColor clearColor];
    _commentCountLable.textColor=[UIColor blackColor];
    [self.contentView addSubview:_commentCountLable];
    
    //来源
    _sourceLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _sourceLabel.font=[UIFont systemFontOfSize:12.0];
    _sourceLabel.backgroundColor=[UIColor clearColor];
    _sourceLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];
    
    //发布时间
    _createLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _createLabel.font=[UIFont systemFontOfSize:12.0];
    _createLabel.backgroundColor=[UIColor clearColor];
    _createLabel.textColor=[UIColor blueColor];
    [self.contentView addSubview:_createLabel];
    
    _weiboView=[[WeiboView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
    //设置cell的选中背景颜色
   UIView *selectedBackgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    selectedBackgroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"statusdetail_cell_sepatator.png"]];
    self.selectedBackgroundView=selectedBackgroundView;
    
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    //用户头像视图
    _userImage.frame=CGRectMake(5, 5, 35, 35);
    NSString *userImageUrl=_weiboModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:userImageUrl]];
    
    //昵称
    _nickLabel.frame=CGRectMake(50, 5, 200, 20);
    _nickLabel.text=_weiboModel.user.screen_name;
    
    //发布时间
    //源日期字符串 Tue May 31 17:46:55 +0800 2011
    NSString *createDate=_weiboModel.createDate;
    if (createDate!=nil) {
        _createLabel.hidden=NO;
        NSString *datestring=[UIUtils fomateString:createDate];
        _createLabel.text=datestring;
        _createLabel.frame=CGRectMake(50, self.height-20, 100, 20);
        [_createLabel sizeToFit];
    }else{
        _createLabel.hidden=YES;
    }
    
    NSString *source=_weiboModel.source;
    //<a href="http://weibo.com" rel="nofollow">新浪微博<a>
    NSString *ret=[self parseSource:source];
    if (ret!=nil) {
        _sourceLabel.hidden=NO;
        _sourceLabel.text=[NSString stringWithFormat:@"来自%@",ret];
        _sourceLabel.frame=CGRectMake(_createLabel.right+8, _createLabel.top, 100, 20);
        [_sourceLabel sizeToFit];
        
    }else{
        _sourceLabel.hidden=YES;
    }
    
    
    //微博视图
    _weiboView.weiboModel=_weiboModel;
    //微博视图_weiboView的数据
    float height=[WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:NO];
    _weiboView.frame=CGRectMake(50, _nickLabel.bottom+10, (320-60), height);
}

-(NSString *)parseSource:(NSString *)source{
    NSString *regex=@">\\w+<";
    NSArray *array=[source componentsSeparatedByRegex:regex];
    if (array.count>0) {
        //>新浪微博<
        NSString *ret=[array objectAtIndex:0];
        NSRange range;
        range.location=1;
        range.length=ret.length-2;
        NSString *resultstring=[ret substringWithRange:range];
        return resultstring;
    }
    return nil;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
