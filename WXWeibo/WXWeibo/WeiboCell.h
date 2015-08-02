//
//  WeiboCell.h
//  WXWeibo
//  自定义微博Cell
//  Created by wangx on 15/7/31.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboView.h"


@interface WeiboCell : UITableViewCell{
    UIImageView     *_userImage;            //用户头像视图
    UILabel         *_nickLabel;                //昵称
    UILabel         *_repostCountLabel;         //转发数
    UILabel         *_commentCountLable;        //回复数
    UILabel         *_sourceLabel;              //发布来源
    UILabel         *_createLabel;              //发布时间
}
//微博数据模型对象
@property(nonatomic,retain) WeiboModel *weiboModel;
//微博视图
@property(nonatomic,retain) WeiboView *weiboView;


@end
