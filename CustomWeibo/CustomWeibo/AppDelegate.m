//
//  AppDelegate.m
//  CustomWeibo
//
//  Created by wangx on 15/8/8.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "AppDelegate.h"
#import "ThemeManager.h"
#import "Constant.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //设置主题
    [self setTheme];
    
    //设置项目中ViewController框架
    _mainCtrl=[[MainViewController alloc]init];
//    LeftViewController *leftCtrl=[[LeftViewController alloc]init];
//    RightViewController *rightCtrl=[[RightViewController alloc]init];
//    _menuCtrl=[[DDMenuController alloc]initWithRootViewController:_mainCtrl];
//    _menuCtrl.leftController=leftCtrl;
//    _menuCtrl.rightController=rightCtrl;
    self.window.rootViewController=_mainCtrl;
    
    return YES;
}

//获取项目的主题信息
-(void)setTheme{
    NSString *themeName=[[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    [[ThemeManager shareInstance]setThemeName:themeName];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
