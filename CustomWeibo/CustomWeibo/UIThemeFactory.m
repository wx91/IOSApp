//
//  UIFactory.m
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "UIThemeFactory.h"

@implementation UIThemeFactory
+(ThemeButton *)createButton:(NSString *)imageName highligted:(NSString *)highlightedName{
    ThemeButton *button=[[ThemeButton alloc]initWithImage:imageName highlighted:highlightedName];

    return button;
}

+(ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName backgroundHighligted:(NSString *)highlightedName{
    ThemeButton *button=[[ThemeButton alloc]initwithBackground:backgroundImageName highlightedBackground:highlightedName];
    return button ;
}

+(UIButton *)createNavigationButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)selector{
    ThemeButton *button = [self createButtonWithBackground:@"navigationbar_button_background.png" backgroundHighligted:@"navigationbar_button_delete_background.png"];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    button.leftCapWidth = 3;
    
    return button;
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
