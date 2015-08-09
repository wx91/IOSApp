//
//  MainViewController.h
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController<UINavigationControllerDelegate>{
    UIView *_tabbarView;            //自定义工具栏
    UIImageView *_sliderView;       //下划线图片
}
//是否显示工具栏
-(void)showTabbar:(BOOL)show;

@end
