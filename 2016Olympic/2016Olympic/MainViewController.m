//
//  MainViewController.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "HomeViewController.h"
#import "EventsViewController.h"
#import "ScheduleViewController.h"
#import "CountDownViewController.h"
#import "AboutViewController.h"


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}


-(void)initViews{
    HomeViewController *home=[[HomeViewController alloc]init];
    UITabBarItem *homeItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"Home.png"] tag:1];
    home.tabBarItem      = homeItem;

    EventsViewController *event=[[EventsViewController alloc]init];
    UINavigationController *eventNavagtion=[[UINavigationController alloc]initWithRootViewController:event];
    UITabBarItem *eventItem=[[UITabBarItem alloc]initWithTitle:@"事件" image:[UIImage imageNamed:@"Events.png"] tag:2];
    event.tabBarItem     = eventItem;

    ScheduleViewController *schedule=[[ScheduleViewController alloc]init];
    UINavigationController *scheduleNavigation=[[UINavigationController alloc]initWithRootViewController:schedule];
    UITabBarItem *scheduleItem=[[UITabBarItem alloc]initWithTitle:@"游戏" image:[UIImage imageNamed:@"Schedule.png"] tag:3];
    schedule.tabBarItem  = scheduleItem;

    CountDownViewController *countDown=[[CountDownViewController alloc]init];
    UITabBarItem *CountDownItem=[[UITabBarItem alloc]initWithTitle:@"计时" image:[UIImage imageNamed:@"CountDown.png"] tag:4];
    countDown.tabBarItem = CountDownItem;


    AboutViewController *about=[[AboutViewController alloc]init];
    UITabBarItem *aboutItem=[[UITabBarItem alloc]initWithTitle:@"关于" image:[UIImage imageNamed:@"About.png"] tag:5];
    about.tabBarItem     = aboutItem;

    NSArray *viewControllers=@[home,eventNavagtion,scheduleNavigation,countDown,about];
    self.viewControllers = viewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
