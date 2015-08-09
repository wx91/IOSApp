//
//  ThemeImageView.m
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView

-(instancetype)init{
    self=[super init];
    if (self) {
        //监听切换主题通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:kThemeDidChageNotification object:nil];
    }
    return self;
}

-(instancetype)initWithimageName:(NSString *)imageName{
    self=[self init];
    if (self) {
        self.imageName=imageName;
    }
    return self;
}
//使用xib创建后，调用初始化方法
-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:kThemeDidChageNotification object:nil];
}


#pragma mark 复写image setter
-(void)setImageName:(NSString *)imageName{
    if (_imageName!=imageName) {
        _imageName=[imageName copy];
    }
    [self loadThemeImage];
}

//加载当前主题下对应的图片
-(void)loadThemeImage{
    if (self.imageName==nil) {
        return ;
    }
    UIImage *image=[[ThemeManager shareInstance]getThemeImage:_imageName];
    image=[image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    
    self.image=image;
}

#pragma mark Notification actions
-(void)themeNotification:(NSNotification *)notification{
    [self loadThemeImage];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeDidChageNotification object:nil];
}


@end
