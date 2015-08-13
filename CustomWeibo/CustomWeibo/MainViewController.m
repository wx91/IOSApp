 //
//  MainViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationViewController.h"
#import "ThemeButton.h"
#import "UIThemeFactory.h"
#import "UIViewExt.h"
#import "Constant.h"

@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tabBar setHidden:YES];
    [self initViewController];
    [self initTabbaerView];
    //每60秒请求未读数接口
//        [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)timerAction:(NSTimer *)timer{
    [WBHttpRequest requestWithAccessToken:[self getToken] url:WB_unRead httpMethod:@"GET" params:nil delegate:self withTag:@"unRead"];
}
- (NSString *)getToken
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"WeiboAuthData"] objectForKey:@"accessToken"];
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
    self.selectedIndex=button.tag;
    
}

//导航控制器的代理方法
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //导航控制器的个数
    NSUInteger count=navigationController.viewControllers.count;
    if (count==2) {
        [self showTabbar:NO];
    }else if(count==1){
        [self showTabbar:YES];
    }
}


//是否显示工具栏
-(void)showTabbar:(BOOL)show{
    [UIView animateWithDuration:0.35 animations:^{
        if (show) {
            _tabbarView.hidden=NO;
        }else{
            _tabbarView.hidden=YES;
        }
    }];
}

- (void)showBadge:(BOOL)show{
    _badgeView.hidden = !show;
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - WBHttpRequest degelate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    if ([request.tag isEqual:@"unRead"]) {
        
        NSError *error;
        NSDictionary *weiboDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",weiboDIC);
        NSNumber *status = [weiboDIC objectForKey:@"status"];  //未读微博
        
        
        if (_badgeView == nil) {
            _badgeView = [UIThemeFactory createImageView:@"main_badge.png"];
            _badgeView.frame = CGRectMake(64 - 25, 5, 20, 20);
            [self.tabBar addSubview:_badgeView];
            
            UILabel *badgeLabel = [[UILabel alloc]initWithFrame:_badgeView.bounds];
            badgeLabel.textAlignment = NSTextAlignmentCenter;
            badgeLabel.backgroundColor = [UIColor clearColor];
            badgeLabel.font = [UIFont boldSystemFontOfSize:13.0f];
            badgeLabel.textColor = [UIColor purpleColor];
            badgeLabel.tag = 100;
            [_badgeView addSubview:badgeLabel];
        }
        int n = [status intValue];
        if (n > 0) {
            UILabel *badgeLabel = (UILabel *)[_badgeView viewWithTag:100];
            if (n > 99) {
                n = 99;
            }
            badgeLabel.text = [NSString stringWithFormat:@"%d",n];
            _badgeView.hidden = NO;
        }else{
            _badgeView.hidden = YES;
        }
        
    }
}


@end
