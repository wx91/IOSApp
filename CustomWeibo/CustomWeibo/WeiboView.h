//
//  WeiboView.h
//  KittenYang
//
//  Created by Kitten Yang on 14-7-22.
//  Copyright (c) 2014年 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "Status.h"
#import "Constant.h"




@interface WeiboView : UIView<RTLabelDelegate>{
@private
    RTLabel         *_textLabel;            //微博内容
    UIImageView     *_image;                //微博图片
    UIImageView     *_repostBackgroundView; //转发微博的背景
    WeiboView       *_repostView;           //转发的微博视图
    NSMutableString  *_parseText;
    
}

//微博数据模型对象
//注：@property是供外部访问的
@property(nonatomic,retain)Status *weiboModel;
//当前微博视图是否是转发的
@property(nonatomic,assign)BOOL isRepost;
//是否是在显示详情页面
@property(nonatomic,assign)BOOL isDetail;


//计算微博视图高度
+(CGFloat)getWeiboViewHeight:(Status *)weiboModel  isDetail:(BOOL)isDetail isRepost:(BOOL)isRepost;
//获取微博字体大小
+(float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost;

@end
