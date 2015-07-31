//
//  ThemeLabel.h
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property(nonatomic,copy)NSString *colorName;

-(instancetype)initwithColorName:(NSString *)colorName;


@end
