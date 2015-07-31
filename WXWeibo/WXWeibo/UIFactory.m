//
//  UIFactory.m
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory
+(ThemeButton *)createButton:(NSString *)imageName highligted:(NSString *)highlightedName{
    ThemeButton *button=[[ThemeButton alloc]initWithImage:imageName highlighted:highlightedName];

    return button;
}

+(ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName backgroundHighligted:(NSString *)highlightedName{
    ThemeButton *button=[[ThemeButton alloc]initwithBackground:backgroundImageName highlightedBackground:highlightedName];
    return button ;
}

+(ThemeImageView *)createImageView:(NSString *)imageName{
    ThemeImageView *themeImageView=[[ThemeImageView alloc]initWithimageName:imageName];
    return themeImageView;
}


+(ThemeLabel *)createLabel:(NSString *)colorName{
    ThemeLabel *themeLabel=[[ThemeLabel alloc]initwithColorName:colorName];
    return themeLabel;
}
@end
