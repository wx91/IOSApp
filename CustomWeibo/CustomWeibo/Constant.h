//
//  Constant.h
//  CustomWeibo
//
//  Created by wangx on 15/8/9.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#ifndef CustomWeibo_Constant_h
#define CustomWeibo_Constant_h
#endif

//weibo OAuth 2.0
#define kAppKey                       @"3601147436"
#define kAppSecret                    @"2e6054e4807cae4173f6c9e13cd3bf91"
#define kAppRedirectURI               @"https://api.weibo.com/oauth2/default.html"


//微博lable颜色设置
#define kNavigationBarTitleLabel      @"kNavigationBarTitleLabel"
#define kThemeListLabel               @"kThemeListLabel"
#define kThemeName                    @"kThemeName"

//获取设备的物理高度
#define ScreenHeight [UIScreen        mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen         mainScreen].bounds.size.width

//微博的相应的设置
#define kWeibo_Width_List             (320-60)                           //微博在列表中的宽度
#define kWeibo_Width_Detail           300                                //微博在详情页面的宽度
#define LIST_FONT                     14.0f                              //列表中的微博内容字体
#define LIST_REPOST_FONT              13.0f                              //列表中转发的文本字体
#define DETAIL_FONT                   18.0f                              //详情的文本字体
#define DETAIL_REPOST_FONT            17.0f                              //详情中的转发字体

//通知
#define kReloadWeiboTableNotification @"kReloadWeiboTableNotification"

//UserDefault Key
#define kThemeName                      @"kThemeName"
#define kBrowseMode                     @"kBrowseMode"

#define LargeBrowseMode                 1                                  //大图浏览模式
#define SmallBrowseMode                 2     //小图浏览模式
//微博API的链接地址
#define WB_home                  @"https://api.weibo.com/2/statuses/friends_timeline.json"
#define WB_unRead                @"https://rm.api.weibo.com/2/remind/unread_count.json"
#define WB_Comments              @"https://api.weibo.com/2/comments/show.json"
#define WB_loadUserData          @"https://api.weibo.com/2/users/show.json"
#define WB_loadUserWeibo         @"https://api.weibo.com/2/statuses/user_timeline.json"
#define WB_postWeibo             @"https://api.weibo.com/2/statuses/update.json"
#define WB_postWeiboWithPic      @"https://upload.api.weibo.com/2/statuses/upload.json"
#define WB_nearBy                @"https://api.weibo.com/2/place/nearby/pois.json"
#define WB_AtMe                  @"https://api.weibo.com/2/statuses/mentions.json"
#define WB_friends               @"https://api.weibo.com/2/friendships/friends.json"
#define WB_fans                  @"https://api.weibo.com/2/friendships/followers.json"
#define WB_nearByWeibo           @"https://api.weibo.com/2/place/nearby_timeline.json"

#define kReloadWeiboNotification @"kReloadWeiboNotification"

#define kReciveAuthorizeResponse @"kReciveAuthorizeResponse"


//首页点击链接
#define kCellContentView         101
//详细页点击链接
#define kModalView               100
