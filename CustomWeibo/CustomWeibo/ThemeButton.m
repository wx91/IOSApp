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

-(instancetype)initWithImage:(NSString *)imageName highlighted:(NSString *)highigtImageName withSelectedImage:(NSString *)selectedImageName{
    self=[self init];
    if (self) {
        self.imageName=imageName;
        self.highigtImageName=highigtImageName;
        self.selectedImageName=selectedImageName;
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
    UIImage *selectedImage=[themeManager getThemeImage:_selectedImageName];
    
    image=[image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    [highligtedImage stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    [selectedImage stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:highligtedImage forState:UIControlStateHighlighted];
    [self setImage:selectedImage forState:UIControlStateSelected];
    
    UIImage *backImage=[themeManager getThemeImage:_backgroundImageName];
    UIImage *backHighligtedImage=[themeManager getThemeImage:_backgroundHighligtImageName];
    
    [backImage stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    [backHighligtedImage stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
                                  
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    [self setBackgroundImage:backHighligtedImage forState:UIControlStateHighlighted];
}

#pragma mark -setter
- (void)setLeftCapWidth:(int)leftCapWidth{
    _leftCapWidth = leftCapWidth;
    [self loadThemeImage];
}

- (void)setTopCapHeight:(int)topCapHeight{
    _topCapHeight = topCapHeight;
    [self loadThemeImage];
    
}

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
-(void)setSelectedImageName:(NSString *)selectedImageName{
    if (_selectedImageName!=selectedImageName) {
        _selectedImageName=[selectedImageName copy];
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


@end
