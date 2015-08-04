//
//  WeiboView.m
//  WXWeibo
//
//  Created by wangx on 15/7/31.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "WeiboView.h"
#import <UIKit/UIKit.h>
#import "UIFactory.h"
#import "UIViewExt.h"
#import "ThemeImageView.h"
#import "UIImageView+WebCache.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"
#import "UIUtils.h"
#import "Constant.h"

#define LIST_FONT 14.0f             //列表中的微博内容字体
#define LIST_REPOST_FONT 13.0f      //列表中转发的文本字体
#define DETAIL_FONT 18.0f           //详情的文本字体
#define DETAIL_REPORT_FONT 17.0f    //详情中的转发字体

@implementation WeiboView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self _initView];
        _parseText=[[NSMutableString alloc]init];
        
    }
    return self;
}
//初始化子视图
-(void)_initView{
    _textLabel=[[RTLabel alloc]initWithFrame:CGRectZero];
    _textLabel.delegate=self;
    _textLabel.font=[UIFont systemFontOfSize:14.0f];
    _textLabel.linkAttributes=[NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    _textLabel.selectedLinkAttributes=[NSDictionary dictionaryWithObject:@"green" forKey:@"color"];
    [self addSubview:_textLabel];
    //微博图片
    _image =[[UIImageView alloc]initWithFrame:CGRectZero];
    _image.image=[UIImage imageNamed:@"page_image_loading.png"];
    [self addSubview:_image];
    
    //微博转换背景
    _repostBackgroundView=[UIFactory createImageView:@"timeline_retweet_background"];
    UIImage *image=[_repostBackgroundView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    _repostBackgroundView.image=image;
    _repostBackgroundView.leftCapWidth=25;
    _repostBackgroundView.topCapHeight=10;
    _repostBackgroundView.backgroundColor=[UIColor clearColor];
    [self insertSubview:_repostBackgroundView atIndex:0];
    
}
//setter
-(void)setWeiboModel:(WeiboModel *)weiboModel{
    if (_weiboModel!=weiboModel) {
        [weiboModel release];
        _weiboModel=[weiboModel retain];
    }
    //创建转发微博视图
    if (_repostBackgroundView==nil) {
        _repostView=[[WeiboView alloc]initWithFrame:CGRectZero];
        _repostView.isRepost=YES;
        _repostView.isDetail=self.isDetail;
        [self addSubview:_repostView];
    }
    [self parseLink];
}



//解析超链接
-(void)parseLink{
    [_parseText setString:@""];
    //判断当前是否为转发微博视图
    if (_isRepost) {
        //将源微博作者拼接
        //源微博作者nick
        NSString *nickName=_weiboModel.user.screen_name;
        NSString *encodeName=[nickName URLEncodedString];
        
        [_parseText appendFormat:@"<a href='user://%@'>%@</a>",encodeName,nickName];
    }
    NSString *text=_weiboModel.text;
    text=[UIUtils parseLink:text];
    
    [_parseText appendString:text];
    
}

//layoutSubviews 展示数据，设置布局
-(void)layoutSubviews{
    [super layoutSubviews];
    //渲染微博文本内容
    [self renderTextLabel];
    //渲染源微博视图
    [self renderSourceWeiboView];
    //渲染微博图片
    [self renderImage];
    
    //转发的微博的视图背景
    if (self.isRepost) {
        _repostBackgroundView.frame=self.bounds;
        _repostBackgroundView.hidden=NO;
    }else{
        _repostBackgroundView.hidden=YES;
    }
}
//渲染微博文本
-(void)renderTextLabel{
    //微博内容_textLabel视图
    float fontSize=[WeiboView getFontSize:self.isDetail isRepost:self.isRepost];
    _textLabel.font=[UIFont systemFontOfSize:fontSize];
    _textLabel.frame=CGRectMake(0, 0, self.width, 20);
    //判断当前视图是否为转发微博视图
    if (self.isRepost) {
        _textLabel.frame=CGRectMake(0, 0, self.width-20, 20);
    }
    _textLabel.text=_parseText;
    //文本内容尺寸
    CGSize textSize=_textLabel.optimumSize;
    _textLabel.height=textSize.height;
}
//渲染源微博
-(void)renderSourceWeiboView{
    WeiboModel *respostWeibo=_weiboModel.relWeibo;
    if (respostWeibo!=nil) {
        _repostView.hidden=NO;
        _repostView.weiboModel=respostWeibo;
        
        float height=[WeiboView getWeiboViewHeight:respostWeibo isRepost:YES isDetail:self.isDetail];
        _repostView.frame=CGRectMake(0, _textLabel.bottom, self.width, height);
        
    }else{
        _repostView.hidden=YES;
    }
}
//渲染微博图片
-(void)renderImage{
    //微博图片视图
    if (self.isDetail) {
        //中等图
        NSString *bmiddleImage=_weiboModel.bmiddleImage;
        if(bmiddleImage!=nil&&[@""isEqualToString:bmiddleImage ]){
            _image.hidden=NO;
            _image.frame=CGRectMake(10, _textLabel.bottom+10, 280, 200);
            
        }else{
            _image.hidden=YES;
        }
    }else{
        NSInteger mode=[[NSUserDefaults standardUserDefaults]integerForKey:kBrowMode];
        if (mode==0) {
            mode=SmallBrowMode;
        }
        if (mode==SmallBrowMode) {//小图浏览模式
            //缩略图
            NSString *thumbnailImage=_weiboModel.thumbnailImage;
            if (thumbnailImage!=nil&&[@"" isEqualToString:thumbnailImage ]) {
                _image.hidden=NO;
                _image.frame=CGRectMake(10, _textLabel.bottom, 70, 80);
                //加载网络图片
                [_image setImageWithURL:[NSURL URLWithString:thumbnailImage]];
            }else{
                _image.hidden=YES;
            }
        }else if(mode==LargeBrowMode){//大图浏览模式
            //中等图
            NSString *bmiddleImage=_weiboModel.bmiddleImage;
            if(bmiddleImage!=nil&&[@""isEqualToString:bmiddleImage ]){
                _image.hidden=NO;
                _image.frame=CGRectMake(10, _textLabel.bottom+10, 280, 200);
                
            }else{
                _image.hidden=YES;
            }
        }

    }
}

+(float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost{
    float fontSize=140.0f;
    if (!isDetail&&!isRepost) {
        return LIST_FONT;
    }else if(!isDetail&&isRepost){
        return LIST_REPOST_FONT;
    }else if (isDetail&&!isDetail){
        return DETAIL_FONT;
    }else if(isDetail&&isRepost){
        return DETAIL_REPORT_FONT;
    }
    return fontSize;
}

+(CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel isRepost:(BOOL)isRepost isDetail:(BOOL) isDetail {
    /**
     * 计算每个子视图的高度，然后享加
     **/
    float height=0;
    
    //计算微博内容text的高度
    RTLabel *textLabel=[[RTLabel alloc]initWithFrame:CGRectZero];
    float fontSize=[WeiboView getFontSize:isDetail isRepost:isRepost];
    textLabel.font=[UIFont systemFontOfSize:fontSize];
    if (isDetail) { //判断微博是否是详情页面
        textLabel.width=kWeibo_Width_Detail;
    }else{
        textLabel.width=kWeibo_Width_List;
    }
    textLabel.text=weiboModel.text;
    height+=textLabel.optimumSize.height;
    
    if (isDetail) {
        NSString *bmiddleImage=weiboModel.bmiddleImage;
        if(bmiddleImage!=nil&&[@""isEqualToString:bmiddleImage ]){
            height+=(200+10);
        }
    }else{
    NSInteger mode=[[NSUserDefaults standardUserDefaults]integerForKey:kBrowMode];
        if (mode==0) {
            mode=SmallBrowMode;
        }
        if(mode==SmallBrowMode){
            //计算微博图片的高度
            NSString *thumbnailImage=weiboModel.thumbnailImage;
            if (thumbnailImage!=nil&&[@"" isEqualToString:thumbnailImage ]) {
                height+=(80+10);
            }
        }else{
            NSString *bmiddleImage=weiboModel.bmiddleImage;
            if(bmiddleImage!=nil&&[@""isEqualToString:bmiddleImage ]){
                height+=(200+10);
            }
        }
    }
    

    
    //转发的微博视图的高度
    WeiboModel *relWeibo=weiboModel.relWeibo;
    if (relWeibo!=nil) {
        //转发微博视图的高度
        float resportHeight=[WeiboView getWeiboViewHeight:relWeibo isRepost:YES isDetail:isDetail];
        height+=resportHeight;
    }
    if (isRepost==YES) {
        height+=height;
    }
    return height;
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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
