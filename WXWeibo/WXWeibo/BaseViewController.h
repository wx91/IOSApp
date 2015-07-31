//
//  BaseViewController.h
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface BaseViewController : UIViewController

@property(nonatomic,assign) BOOL isBackButton;


-(SinaWeibo *)sinaweibo;

@end
