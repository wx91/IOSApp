//
//  WeiboView.h
//  WXWeibo
//
//  Created by wangx on 15/7/31.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "RTLabel.h"
#import "ThemeImageView.h"

#define kWeibo_Width_List   (320-60)  //微博在列表中的宽度
#define kWeibo_Width_Detail 300       //微博在详情页面的宽度

@interface WeiboView : UIView<RTLabelDelegate>{
    RTLabel *_textLabel;                    //微博内容
    UIImageView *_image;                    //微博图片
    ThemeImageView *_repostBackgroundView;     //转发的微博视图背景
    WeiboView *_repostView;                 //转发的微博视图
    NSMutableString  *_parseText;
}
//微博数据模型对象
@property(nonatomic,retain)WeiboModel *weiboModel;

@property(nonatomic,assign) BOOL isDetail;
//当前的微博视图是否是转发微博
@property(nonatomic,assign) BOOL isRepost;

+(float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost;

//计算微博视图的高度
+(CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel isRepost:(BOOL)isRepost isDetail:(BOOL) isDetail ;



@end
