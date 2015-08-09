//
//  AppDelegate.h
//  CustomWeibo
//
//  Created by wangx on 15/8/8.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong,nonatomic) UIWindow *window;

@property(strong,retain) MainViewController *mainCtrl;

@property(nonatomic,retain)DDMenuController *menuCtrl;


@end

