//
//  BaseViewController.h
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
@interface BaseViewController : UIViewController{
    UIView *_loadView;
}

@property(nonatomic,assign) BOOL isBackButton;
@property(nonatomic,retain) MBProgressHUD *hud;


-(SinaWeibo *)sinaweibo;

-(AppDelegate *)appDelegate;

//提示
-(void)showLoading:(BOOL )show;

-(void)showHUD:(NSString *)title isDim:(BOOL)isDim;

-(void)showHUDComplete:(NSString *)title;

-(void)hideHUD;

@end
