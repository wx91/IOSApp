//
//  AppDelegate.h
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "MainViewController.h"
#import "DDMenuController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong ,nonatomic)SinaWeibo *sinaweibo;

@property(strong,retain) MainViewController *mainCtrl;

@property(nonatomic,retain)DDMenuController *menuCtrl;

@end

