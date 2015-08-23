//
//  MainViewController.m
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "JZOnSiteViewController.h"
#import "JZMerchantViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"
#import "Constant.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbar];
}



#pragma mark 开始初始化toolbar
-(void)initTabbar{
    HomeViewController *home=[[HomeViewController alloc]init];
    JZOnSiteViewController *onsite=[[JZOnSiteViewController alloc]init];
    JZMerchantViewController *merchant=[[JZMerchantViewController alloc]init];
    MineViewController *mine=[[MineViewController alloc]init];
    MoreViewController *more=[[MoreViewController alloc]init];
    NSArray *views=@[home,onsite,merchant,mine,more];
    NSArray *titles=@[@"团购",@"上门",@"商家",@"我的",@"更多"];
    NSArray *images=@[@"icon_tabbar_homepage",@"icon_tabbar_onsite",@"icon_tabbar_merchant_normal",@"icon_tabbar_mine",@"icon_tabbar_misc"];
    NSArray *imageSelecteds=@[@"icon_tabbar_homepage_selected",@"icon_tabbar_onsite_selected",@"icon_tabbar_merchant_selected",@"icon_tabbar_mine_selected",@"icon_tabbar_misc_selected"];
    NSMutableArray *navs=[[NSMutableArray alloc]initWithCapacity:5];
    for (int i=0; i<views.count; i++) {
        //获取标题
        NSString *title=[titles objectAtIndex:i];
        //获取图片
        NSString *image=[images objectAtIndex:i];
        //获取选中后的图片
        NSString *imageSelected=[imageSelecteds objectAtIndex:i];
        UITabBarItem *item=[[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:imageSelected]];
        UIViewController *viewController=[views objectAtIndex:i];
        viewController.title=title;
        viewController.tabBarItem=item;
        
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:viewController];
        [navs addObject:nav];
    }
    self.viewControllers=navs;
}


#pragma mark 禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma System Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
