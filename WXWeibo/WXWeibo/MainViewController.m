 //
//  MainViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "ThemeButton.h"
#import "UIThemeFactory.h"
#import "BaseNavigationViewController.h"
#import "UIViewExt.h"
#import "UIViewExt.h"

@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tabBar setHidden:YES];
    [self initViewController];
    [self initTabbaerView];
    //每60秒请求未读数接口
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

//初始化自控制器
-(void)initViewController{
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
        nav.delegate=self;
    }
    self.viewControllers=viewControllers;
}
//创建自定义tabBar
-(void)initTabbaerView{
    _tabbarView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
    //    _tabbarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    [self.view addSubview:_tabbarView];
    UIImageView *tabbarGroundImage=[UIThemeFactory createImageView:@"tabbar_background.png"];
    tabbarGroundImage.frame=_tabbarView.bounds;
    [_tabbarView addSubview:tabbarGroundImage];
    NSArray *background=@[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    NSArray *hightbackground=@[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    for (int i=0; i<background.count; i++) {
        NSString *backImage= background[i];
        NSString *highImage=hightbackground[i];
        UIButton *button=[UIThemeFactory createButtonWithBackground:backImage backgroundHighligted:highImage];
        button.showsTouchWhenHighlighted=YES;
        button.frame=CGRectMake((64-30)/2+(i*64), (49-30)/2, 30, 30);
        button.tag=i;
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
    }
    _sliderView =[UIThemeFactory createImageView:@"tabbar_slider.png"];
    _sliderView.frame=CGRectMake((64-15)/2, 5, 15, 44);
    [_tabbarView addSubview:_sliderView];
}

//点击切换
-(void)selectedTab:(UIButton *)button{
    float x=button.left+(button.width-_sliderView.width)/2;
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.left=x;
    }];
    [button setHighlighted:YES];
    //判断是否是重复点击tab按钮
    if (button.tag==self.selectedIndex&&button.tag==0) {
        UINavigationController *homeNav=[self.viewControllers objectAtIndex:0];
        HomeViewController *homeCtrl=[homeNav.viewControllers objectAtIndex:0];
//        [_homeCtrl refreshWeibo];
    }
    self.selectedIndex=button.tag;
    
}
//读取未读的数据
-(void)timerAction:(NSTimer *)timer{
    [self loadUnReadData];
}

//导航控制器的代理方法
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //导航控制器的个数
    int count=navigationController.viewControllers.count;
    if (count==2) {
        [self showTabbar:NO];
    }else if(count==1){
        [self showTabbar:YES];
    }
    [self resizeView:shadow];
}


//是否显示未读微博提示信息
-(void)showBadge:(BOOL )show{
    _badgeView.hidden=!show;
}
//是否显示工具栏
-(void)showTabbar:(BOOL)show{
    [UIView animateWithDuration:0.35 animations:^{
        if (show) {
            _tabbarView.left=0;
            //            _tabbarView.hidden=NO;
        }else{
            _tabbarView.left=-ScreenWidth;
            //            _tabbarView.hidden=YES;
        }
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
//        [_homeCtrl refreshWeibo];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    //移除认证信息
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    NSLog(@"sinaweiboLogInDidCancel");
}
//请求方法
-(void)loadUnReadData{
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo =appdelegate.sinaweibo;
    [sinaweibo requestWithURL:@"remind/unread_count.json" params:nil httpMethod:@"GET" block:^(id result) {
        [self refreshUnreadView:result];
    }];
}
//解析请求方法的数据
-(void)refreshUnreadView:(id )result{
    NSNumber *status=[result objectForKey:@"status"];
    if (_badgeView==nil) {
        _badgeView =[UIThemeFactory createImageView:@"main_badge.png"];
        _badgeView.frame=CGRectMake(64-20, 5, 20, 20);
        [_tabbarView addSubview:_badgeView];
        
        UILabel *badgeLabel=[[UILabel alloc]initWithFrame:_badgeView.bounds];
        badgeLabel.textAlignment=NSTextAlignmentCenter;
        badgeLabel.backgroundColor=[UIColor clearColor];
        badgeLabel.font=[UIFont boldSystemFontOfSize:13.0f];
        badgeLabel.textColor=[UIColor purpleColor];
        badgeLabel.tag=100;
        [_badgeView addSubview:badgeLabel];
    }
    int n=[status intValue];
    if (n>0) {
        UILabel *badgeLabel=(UILabel *)[_badgeView viewWithTag:100];
        if (n>99) {
            n=99;
        }
        badgeLabel.text=[NSString stringWithFormat:@"%@",status];
        _badgeView.hidden=NO;
    }else{
        _badgeView.hidden=YES;
    }
}

//导航控制器调用方法
-(void)resizeView:(BOOL)showTabbar{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (showTabbar) {
                subView.height=ScreenHeight-49-20;
            }else{
                subView.height=ScreenHeight-20;
            }
        }
    }
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
