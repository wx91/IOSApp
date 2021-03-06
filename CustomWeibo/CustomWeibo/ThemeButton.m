//
//  ThemeButton.m
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton

-(instancetype)init{
    self=[super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:kThemeDidChageNotification object:nil];
    }
    return self;
}

-(instancetype)initWithImage:(NSString *)imageName highlighted:(NSString *)highigtImageName{
    if ([self init]) {
        self.imageName=imageName;
        self.highigtImageName=highigtImageName;
    }
    return self;
}

-(instancetype)initwithBackground:(NSString *)backgroundImageName highlightedBackground:(NSString *)backgroundHighligtImageName{
    if ([self init]) {
        self.backgroundImageName=backgroundImageName;
        self.backgroundHighligtImageName=backgroundHighligtImageName;
    }
    return self;
}



-(void)themeNotification:(NSNotification *)notification{
    [self loadThemeImage];
}

-(void)loadThemeImage{
    ThemeManager *themeManager=[ThemeManager shareInstance];
    UIImage *image=[themeManager getThemeImage:_imageName];
    UIImage *highligtedImage=[themeManager getThemeImage:_highigtImageName];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:highligtedImage forState:UIControlStateHighlighted];
    
    UIImage *backImage=[themeManager getThemeImage:_backgroundImageName];
    UIImage *backHighligtedImage=[themeManager getThemeImage:_backgroundHighligtImageName];
    
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    [self setBackgroundImage:backHighligtedImage forState:UIControlStateHighlighted];
}

#pragma mark -setter
//重写imagename
-(void)setImageName:(NSString *)imageName{
    if (_imageName!=imageName) {
        _imageName=[imageName copy];
    }
    [self loadThemeImage];
}
-(void)setHighigtImageName:(NSString *)highigtImageName{
    if (_highigtImageName!=highigtImageName) {
        _highigtImageName=[highigtImageName copy];
    }
    [self loadThemeImage];
    
}
-(void)setBackgroundImageName:(NSString *)backgroundImageName{
    if (_backgroundImageName!=backgroundImageName) {
        _backgroundImageName=[backgroundImageName copy];
    }
    [self loadThemeImage];
}
-(void)setBackgroundHighligtImageName:(NSString *)backgroundHighligtImageName{
    if (_backgroundHighligtImageName!=backgroundHighligtImageName) {
        _backgroundHighligtImageName=[backgroundHighligtImageName copy];
    }
    [self loadThemeImage];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)setLeftCapWidth:(int)leftCapWidth{
    _leftCapWidth = leftCapWidth;
    [self loadThemeImage];
}

- (void)setTopCapHeight:(int)topCapHeight{
    _topCapHeight = topCapHeight;
    [self loadThemeImage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
