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
    UIView *_tabbarView;
    UIImageView *_sliderView;
    UIImageView *_badgeView;
}

-(void)showBadge:(BOOL )show;

-(void)showTabbar:(BOOL)show;
@end
