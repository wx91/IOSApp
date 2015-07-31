 //
//  MainViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationViewController.h"x 
#import "ThemeButton.h"
#import "UIFactory.h"
#import "UIViewExt.h"


//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation MainViewController

-(void)loadView{
    [super loadView];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tabBar setHidden:YES];
    [self _initViewController];
    [self _initTabbaerView];
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
//初始化自控制器
-(void)_initViewController{
    HomeViewController *home=[[HomeViewController alloc]init];
    MessageViewController *message=[[MessageViewController alloc]init];
    ProfileViewController *profile=[[ProfileViewController alloc]init];
    DiscoverViewController *discover=[[DiscoverViewController alloc]init];
    MoreViewController *more=[[MoreViewController alloc]init];
    NSMutableArray *viewControllers=[NSMutableArray arrayWithCapacity:5];
    NSArray *views =@[home,message,profile,discover,more];
    
    for (BaseViewController *viewController in views) {
        BaseNavigationViewController *nav=[[BaseNavigationViewController alloc]initWithRootViewController:viewController];
        [viewControllers addObject:nav];
    }
    self.viewControllers=viewControllers;
}
//创建自定义tabBar
-(void)_initTabbaerView{
    _tabbarView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
//    _tabbarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    [self.view addSubview:_tabbarView];
    UIImageView *tabbarGroundImage=[UIFactory createImageView:@"tabbar_background.png"];
    tabbarGroundImage.frame=_tabbarView.bounds;
    [_tabbarView addSubview:tabbarGroundImage];
    
    NSArray *background=@[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    NSArray *hightbackground=@[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    for (int i=0; i<background.count; i++) {
        NSString *backImage= background[i];
        NSString *highImage=hightbackground[i];
        
        UIButton *button=[UIFactory createButtonWithBackground:backImage backgroundHighligted:highImage];
        button.frame=CGRectMake((64-30)/2+(i*64), (49-30)/2, 30, 30);
        button.tag=i;
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
        
    }
    
    _sliderView =[UIFactory createImageView:@"tabbar_slider.png"];
    _sliderView.frame=CGRectMake((64-15)/2, 5, 15, 44);
    [_tabbarView addSubview:_sliderView];
}
//点击切换
-(void)selectedTab:(UIButton *)button{
    self.selectedIndex=button.tag;
    float x=button.left+(button.width-_sliderView.width)/2;
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.left=x;
    }];
}

#pragma mark SinaWeibo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    //保存认证数据到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    //移除认证信息
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
     NSLog(@"sinaweiboLogInDidCancel");
}

@end
