//
//  WeiboView.m
//  WXWeibo
//
//  Created by wangx on 15/7/31.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "WeiboView.h"
#import <UIKit/UIKit.h>
#import "UIThemeFactory.h"
#import "UIViewExt.h"
#import "ThemeImageView.h"
#import "UIImageView+WebCache.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"
#import "UIUtils.h"
#import "UIViewExt.h"
#import "Constant.h"

@implementation WeiboView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
        [_parseText init];
    }
    return self;
}

//初始化子视图
- (void)_initView {
    //微博内容
    _textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    _textLabel.delegate = self;
    _textLabel.font = [UIFont systemFontOfSize:14.0f];
    //十进制RGB值：r:69 g:149 b:203
    //十六进制RGB值：4595CB
    //设置链接的颜色
    _textLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    //设置链接高亮的颜色
    _textLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    [self addSubview:_textLabel];
    
    //微博图片
    _image = [[UIImageView alloc] initWithFrame:CGRectZero];
    _image.backgroundColor = [UIColor clearColor];
    _image.image = [UIImage imageNamed:@"page_image_loading.png"];
    //设置图片的内容显示模式：等比例缩/放（不会被拉伸或压缩）
    _image.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_image];
    
    //转发微博视图的背景
    _repostBackgroudView = [UIThemeFactory createImageView:@"timeline_retweet_background.png"];
    UIImage *image = [_repostBackgroudView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    _repostBackgroudView.image = image;
    _repostBackgroudView.leftCapWidth = 25;
    _repostBackgroudView.topCapHeight = 10;
    _repostBackgroudView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_repostBackgroudView atIndex:0];
    
}

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }
    
    //创建转发微博视图
    if (_repostView == nil) {
        _repostView = [[WeiboView alloc] initWithFrame:CGRectZero];
        _repostView.isRepost = YES;
        [self addSubview:_repostView];
    }
}

//layoutSubviews 展示数据、子视图布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //---------------微博内容_textLabel子视图------------------
    //获取字体大小
    float fontSize = [WeiboView getFontSize:self.isDetail isRepost:self.isRepost];
    _textLabel.font = [UIFont systemFontOfSize:fontSize];
    _textLabel.frame = CGRectMake(0, 0, self.width, 20);
    //判断当前视图是否为转发视图
    if (self.isRepost) {
        _textLabel.frame = CGRectMake(10, 10, self.width-20, 0);
    }
    NSString *text=_weiboModel.text;
    text=[self parseLink:text];
    _textLabel.text = text;
    //文本内容尺寸
    CGSize textSize = _textLabel.optimumSize;
    _textLabel.height = textSize.height;
    
    
    //---------------转发的微博视图_repostView------------------
    //转发的微博model
    WeiboModel *repostWeibo = _weiboModel.relWeibo;
    if (repostWeibo != nil) {
        _repostView.hidden = NO;
        _repostView.weiboModel = repostWeibo;
        
        //计算转发微博视图的高度
        float height = [WeiboView getWeiboViewHeight:repostWeibo isRepost:YES isDetail:self.isDetail];
        _repostView.frame = CGRectMake(0, _textLabel.bottom, self.width, height);
    } else {
        _repostView.hidden = YES;
    }
    
    
    //---------------微博图片视图_image------------------
    NSString *thumbnailImage = _weiboModel.thumbnailImage;
    if (thumbnailImage != nil && ![@"" isEqualToString:thumbnailImage]) {
        _image.hidden = NO;
        _image.frame = CGRectMake(10, _textLabel.bottom+10, 70, 80);
        
        //加载网络图片数据
        [_image setImageWithURL:[NSURL URLWithString:thumbnailImage]];
    } else {
        _image.hidden = YES;
    }
    //----------------转发的微博视图背景_repostBackgroudView---------------
    if (self.isRepost) {
        _repostBackgroudView.frame = self.bounds;
        _repostBackgroudView.hidden = NO;
    } else {
        _repostBackgroudView.hidden = YES;
    }
    
}



#pragma mark - 计算
//获取字体大小
+ (CGFloat)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost {
    float fontSize = 14.0f;
    if (!isDetail && !isRepost) {
        return LIST_FONT;
    }
    else if(!isDetail && isRepost) {
        return LIST_REPOST_FONT;
    }
    else if(isDetail && !isRepost) {
        return DETAIL_FONT;
    }
    else if(isDetail && isRepost) {
        return DETAIL_REPOST_FONT;
    }
    
    return fontSize;
}

//计数微博视图的高度
+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel
                     isRepost:(BOOL)isRepost
                     isDetail:(BOOL)isDetail {
    /**
     *   实现思路：计算每个子视图的高度，然后相加。
     **/
    float height = 0;
    
    //--------------------计算微博内容text的高度------------------------
    RTLabel *textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    float fontsize = [WeiboView getFontSize:isDetail isRepost:isRepost];
    textLabel.font = [UIFont systemFontOfSize:fontsize];
    //判断此微博是否显示在详情页面
    if (isDetail) {
        textLabel.width = kWeibo_Width_Detail;
    } else {
        textLabel.width = kWeibo_Width_List;
    }
    

    NSMutableString *str=[[NSMutableString alloc]init];
    //判断当前是否为转发微博视图
    if (isRepost) {
        //将源微博作者拼接
        //源微博作者nick
        NSString *nickName=weiboModel.user.screen_name;
        NSString *encodeName=[nickName URLEncodedString];
        
        [str appendFormat:@"<a href='user://%@'>%@</a>",encodeName,nickName];
    }
    NSString *text=weiboModel.text;
    text=[UIUtils parseLink:text];
    [str appendString:text];
//    textLabel.text=weiboModel.text;
    textLabel.text =str;
    
    height += textLabel.optimumSize.height;
    
    //--------------------计算微博图片的高度------------------------
    NSString *thumbnailImage = weiboModel.thumbnailImage;
    if (thumbnailImage != nil && ![@"" isEqualToString:thumbnailImage]) {
        height += (80+10);
    }
    
    //--------------------计算转发微博视图的高度------------------------
    //转发的微博
    WeiboModel *relWeibo = weiboModel.relWeibo;
    if (relWeibo != nil) {
        //转发微博视图的高度
        float repostHeight = [WeiboView getWeiboViewHeight:relWeibo isRepost:YES isDetail:isDetail];
        height += (repostHeight);
    }
    
    if (isRepost == YES) {
        height += 30;
    }
    
    return height;
}

//解析超链接
-(NSString *)parseLink:(NSString *)text{
//    [_parseText setString:@""];
//    NSString *text=_weiboModel.text;
//    [_parseText appendString:text];
//判断当前是否为转发微博视图
    if (_isRepost) {
        //将源微博作者拼接
        //源微博作者nick
        NSString *nickName=_weiboModel.user.screen_name;
        NSString *encodeName=[nickName URLEncodedString];
        [_parseText appendFormat:@"<a href='user://%@'>%@</a>",encodeName,nickName];
    }
    text=[UIUtils parseLink:text];
    return text;
}

#pragma mark RTLabel deleagte
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
    NSString *absoluteString=[url absoluteString];
    if ([absoluteString hasPrefix:@"user"]) {
        NSString *urlstring=[url host];
        urlstring=[urlstring URLDecodedString];
    }else if ([absoluteString hasPrefix:@"http"]){
        NSLog(@"%@",absoluteString);
    }else if ([absoluteString hasPrefix:@"topic"]){
        NSString *urlstring=[url host];
        urlstring=[urlstring URLDecodedString];
    }
}

@end
