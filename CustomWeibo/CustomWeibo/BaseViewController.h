//
//  BaseViewController.h
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"


@interface BaseViewController : UIViewController<MBProgressHUDDelegate>{
    UIWindow *tipWindow;
}
//是否需要返回按钮
@property(nonatomic,assign) BOOL isBackButton;
//提示框架
@property(nonatomic,retain) MBProgressHUD *hud;

-(AppDelegate *)appDelegate;

-(void)showLoading:(BOOL)show;
//进行提示
-(void)showHUD:(NSString *)title isDim:(BOOL)isDim;
//完成提示
-(void)showHUDComplete:(NSString *)title;
//隐藏提示
-(void)hideHUD;

//状态栏上的提示
-(void)showStatusTip:(BOOL)show title:(NSString *)title;

-(void)multipleValue:(NSArray *)array;
@end
