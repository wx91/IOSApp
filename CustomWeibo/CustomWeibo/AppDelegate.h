//
//  AppDelegate.h
//  CustomWeibo
//
//  Created by wangx on 15/8/8.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "WeiboSDK.h"
#import "DDMenuController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>


@property (strong, nonatomic) NSString *wbtoken;

@property (strong,nonatomic) NSDate  *wbexpirationDate;

@property (strong,nonatomic) NSString  *HostUserID;

@property (strong,nonatomic) UIWindow *window;

@property(strong,retain) MainViewController *mainCtrl;

@property (strong,nonatomic) DDMenuController *menuCtrl;

@end

