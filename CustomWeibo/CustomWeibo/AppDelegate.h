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
#import "WeiboSDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>


@property (strong, nonatomic) NSString *wbtoken;

@property (strong,nonatomic) NSDate  *wbexpirationDate;

@property (strong,nonatomic) NSString  *HostUserID;

@property (strong,nonatomic) UIWindow *window;

@property(strong,retain) MainViewController *mainCtrl;

@property(nonatomic,retain)DDMenuController *menuCtrl;



@end

