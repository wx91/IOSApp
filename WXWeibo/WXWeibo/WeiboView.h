//
//  WeiboView.h
//  WXWeibo
//
//  Created by wangx on 15/7/31.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "WeiboModel.h"
#import "ThemeImageView.h"
#import "Constant.h"

@interface WeiboView : UIView<RTLabelDelegate>{
    RTLabel *_textLabel;                    //微博内容
    UIImageView *_image;                     //微博图片
    ThemeImageView *_repostBackgroudView;  //转发的微博视图背景
    WeiboView *_repostView;                  //转发的微博视图
    NSMutableString *_parseText;
}

//微博模型对象
@property(nonatomic,retain)WeiboModel *weiboModel;
//当前的微博视图，是否是转发的
@property(nonatomic,assign)BOOL isRepost;

//微博视图是否显示在详情页面
@property(nonatomic,assign)BOOL isDetail;
//获取字体大小
+ (CGFloat)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost;
//计数微博视图的高度
+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel
                     isRepost:(BOOL)isRepost
                     isDetail:(BOOL)isDetail;

@end
