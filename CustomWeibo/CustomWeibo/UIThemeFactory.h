//
//  UIFactory.h
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"

@interface UIThemeFactory : NSObject

+(ThemeButton *)createButton:(NSString *)imageName highligted:(NSString *)highlightedName;

+(ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName backgroundHighligted:(NSString *)highlightedName;

+(UIButton *)createNavigationButton:(CGRect)frame
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)selector;
+(ThemeImageView *)createImageView:(NSString *)imageName;

+(ThemeLabel *)createLabel:(NSString *)colorName;

@end
