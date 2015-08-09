//
//  ThemeLabel.m
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel

-(instancetype)init{
    self=[super init];
    if (self) {
    //监听切换主题通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:kThemeDidChageNotification object:nil];
    }
    return self;
}

-(instancetype)initwithColorName:(NSString *)colorName{
    if ([super init]) {
        self.colorName=colorName;
    }
    return self;
}

-(void)setColor{
    UIColor *textColor=[[ThemeManager shareInstance]getColorWithName:_colorName];
    self.textColor=textColor;
}

-(void)setColorName:(NSString *)colorName{
    if (_colorName!=colorName) {
        _colorName=[colorName copy];
    }
    [self setColor];
}
-(void)themeNotification:(NSNotification *)notification{
    [self setColor];
}


@end
