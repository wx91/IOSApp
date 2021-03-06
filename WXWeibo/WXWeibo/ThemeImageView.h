//
//  ThemeImageView.h
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,assign)int leftCapWidth;

@property(nonatomic,assign)int topCapHeight;


-(instancetype)initWithimageName:(NSString *)imageName;

@end
