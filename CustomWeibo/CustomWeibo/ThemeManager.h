//
//  ThemeManager.h
//  WXWeibo
//  主题管理类
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kThemeDidChageNotification @"kThemeDidChageNotification"

@interface ThemeManager : NSObject
//当前使用的主题名称
@property(nonatomic,retain)NSString *themeName;

@property(nonatomic,retain)NSDictionary *themePlist;

@property(nonatomic,retain)NSDictionary *fontColorPlist;

+(ThemeManager *)shareInstance;

//返回当前主题的路径
-(NSString *)getThemePath;

//返回当前主题下，图片名称
-(UIImage *)getThemeImage:(NSString *)imageName;

-(UIColor *)getColorWithName:(NSString *)name;

@end
