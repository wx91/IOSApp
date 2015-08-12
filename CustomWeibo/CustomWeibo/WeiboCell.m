  //
//  WeiboCell.m
//  KittenYang
//
//  Created by Kitten Yang on 14-7-22.
//  Copyright (c) 2014年 Kitten Yang. All rights reserved.
//

#import "WeiboCell.h"
#import <QuartzCore/QuartzCore.h>  //带圆角头像需要用到的库
#import "WeiboView.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"

//#import "ProfileModalViewController.h"
#import "UIViewExt.h"
#import "Constant.h"
#import "RegexKitLite.h"

@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

//初始化子视图
- (void)_initView{

    self.contentView.tag = kCellContentView;
    
    //--------------------------用户头像--------------------------
    _userImage =  [[UIImageView alloc]initWithFrame:CGRectZero];
    _userImage.backgroundColor = [UIColor clearColor];
    _userImage.layer.cornerRadius = 5;     //圆弧半径
    _userImage.layer.borderWidth  = .5;
    _userImage.layer.borderColor  =[UIColor grayColor].CGColor;
    _userImage.layer.masksToBounds = YES;  //超出部分裁剪掉

    //给用户头像添加一个tap的手势操作
    _userImage.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToUser)];
    [_userImage addGestureRecognizer:tap];
    
    [self.contentView addSubview:_userImage];
    
    //----------------------------昵称--------------------------
    _nickLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _nickLabel.backgroundColor = [UIColor clearColor];
    _nickLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nickLabel];
    
    
    
    //----------------------------转发数--------------------------
    _repostLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _repostLabel.font = [UIFont systemFontOfSize:12.0];
    _repostLabel.backgroundColor = [UIColor clearColor];
    _repostLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_repostLabel];

    
    //----------------------------回复数--------------------------
    _commentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _commentLabel.font = [UIFont systemFontOfSize:12.0];
    _commentLabel.backgroundColor = [UIColor clearColor];
    _commentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_commentLabel];

    
    //----------------------------发布来源--------------------------
    _sourceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _sourceLabel.font = [UIFont systemFontOfSize:12.0];
    _sourceLabel.backgroundColor = [UIColor clearColor];
    _sourceLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];
    
    
    
    //----------------------------发布时间--------------------------
    _createLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _createLabel.font = [UIFont systemFontOfSize:12.0];
    _createLabel.backgroundColor = [UIColor clearColor];
    _createLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_createLabel];
    
    
    _weiboView = [[WeiboView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    //--------------------------用户头像--------------------------
    _userImage.frame = CGRectMake(5, 5, 35, 35);
    NSString *userImageURL =  _weiboModel.user.profile_image_url;
    [_userImage sd_setImageWithURL:[NSURL URLWithString:userImageURL]];

    
    
    //--------------------------昵称--------------------------
    _nickLabel.frame = CGRectMake(50, 5, 200, 20);
    _nickLabel.text = _weiboModel.user.screen_name;
    
    
    
    //--------------------------微博视图--------------------------
    _weiboView.weiboModel = _weiboModel;
    float h = [WeiboView getWeiboViewHeight:_weiboModel isDetail:NO isRepost: NO];
    _weiboView.frame = CGRectMake(50, _nickLabel.bottom + 10,kWeibo_Width_List, h);

    //调用WeiboView重新布局
    [_weiboView setNeedsLayout];
    
    
    //--------------------------发布时间--------------------------
    /********日期格式化字符对照表*********
     * 字母	日期或时间元素	表示	示例
     * G	Era 标志符	Text	AD
     * y	年	Year	1996; 96
     * M	年中的月份	Month	July; Jul; 07
     * w	年中的周数	Number	27
     * W	月份中的周数	Number	2
     * D	年中的天数	Number	189
     * d	月份中的天数	Number	10
     * F	月份中的星期	Number	2
     * E	星期中的天数	Text	Tuesday; Tue
     * a	Am/pm 标记	Text	PM
     * H	一天中的小时数（0-23）	Number	0
     * k	一天中的小时数（1-24）	Number	24
     * K	am/pm 中的小时数（0-11）	Number	0
     * h	am/pm 中的小时数（1-12）	Number	12
     * m	小时中的分钟数	Number	30
     * s	分钟中的秒数	Number	55
     * S	毫秒数	Number	978
     * z	时区	General time zone	Pacific Standard Time; PST; GMT-08:00
     * Z	时区	RFC 822 time zone	-0800
     ***/
    //格式：Tue May 31 17:46:55 +0800 2011
    //E M d HH:mm:ss Z yyyy
    //显示成"01-20 16:20"
    NSString *createDate = _weiboModel.createDate;
    NSString *dateString = [UIUtils fomateString:createDate];
    _createLabel.text = dateString;
    _createLabel.frame = CGRectMake(50,self.height-20, 100, 20);
    [_createLabel sizeToFit];
    
    
    //--------------------------微博来源--------------------------
    //<a href="http://weibo.com" rel="nofollow">新浪微博</a>
    NSString *source = _weiboModel.source;
    NSString *ret = [self parseSource:source];
        _sourceLabel.text = [NSString stringWithFormat:@"来自%@",ret];
        _sourceLabel.frame = CGRectMake(_createLabel.right + 8, _createLabel.top, 100, 20);
        [_sourceLabel sizeToFit];

    
    
}

- (NSString *)parseSource:(NSString *)source{
    NSString *regex = @">(.+?)+<";
    NSArray *array = [source componentsMatchedByRegex:regex];
    if (array.count > 0) {
        //>新浪微博<
        NSString *ret= [array objectAtIndex:0];
        NSRange range;
        range.location = 1;
        range.length = ret.length - 2;
        NSString *resultString = [ret substringWithRange:range];
        return resultString;
    }
    return nil;
}
    //首页点击头像进入用户主页
#pragma mark -- pushToUser
- (void) pushToUser{
//    ProfileModalViewController *modalVC = [[ProfileModalViewController alloc]init];
//    modalVC.userName = self.weiboModel.user.screen_name;
//    [self.viewController.navigationController pushViewController:modalVC animated:YES];
}

#pragma mark -- 系统自带可忽略
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
