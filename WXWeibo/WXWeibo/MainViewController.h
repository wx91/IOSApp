//
//  MainViewController.h
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface MainViewController : UITabBarController<SinaWeiboDelegate,UINavigationControllerDelegate>{
    UIView *_tabbarView;            //自定义工具栏
    UIImageView *_sliderView;       //下划线图片
    UIImageView *_badgeView;        //小尖角提醒
//    HomeViewController *_homeCtrl;  //homeCtrl实例
}
//是否显示未读微博提示信息
-(void)showBadge:(BOOL )show;
//是否显示工具栏
-(void)showTabbar:(BOOL)show;

@end
