//
//  ThemeButton.h
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *highigtImageName;

@property(nonatomic,copy)NSString *backgroundImageName;
@property(nonatomic,copy)NSString *backgroundHighligtImageName;

-(instancetype)initWithImage:(NSString *)imageName highlighted:(NSString *)highigtImageName;

-(instancetype)initwithBackground:(NSString *)backgroundImageName highlightedBackground:(NSString *)backgroundHighligtImageName;

@end
