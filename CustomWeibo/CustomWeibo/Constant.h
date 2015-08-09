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
#define kAppKey @"3601147436"
#define kAppSecret @"2e6054e4807cae4173f6c9e13cd3bf91"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"


//微博lable颜色设置
#define kNavigationBarTitleLabel @"kNavigationBarTitleLabel"
#define kThemeListLabel @"kThemeListLabel"
#define kThemeName @"kThemeName"

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//微博的相应的设置
#define kWeibo_Width_List (320-60)  //微博在列表中的宽度
#define kWeibo_Width_Detail 300     //微博在详情页面的宽度
#define LIST_FONT 14.0f             //列表中的微博内容字体
#define LIST_REPOST_FONT 13.0f      //列表中转发的文本字体
#define DETAIL_FONT 18.0f           //详情的文本字体
#define DETAIL_REPOST_FONT 17.0f    //详情中的转发字体

//通知
#define kReloadWeiboTableNotification @"kReloadWeiboTableNotification"

//UserDefault Key
#define kThemeName @"kThemeName"
#define kBrowMode  @"kBrowMode"

#define LargeBrowMode 1     //大图浏览模式
#define SmallBrowMode 2     //小图浏览模式
