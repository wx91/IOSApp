//
//  BaseNavigationViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "ThemeManager.h"

@implementation BaseNavigationViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //添加切换监听
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:kThemeDidChageNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadThemeImage];
    UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipAction:)];
    swipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGesture];
    
}
//左扫时，返回上一个页面
-(void)swipAction:(UISwipeGestureRecognizer *)gesture{
    if(self.viewControllers.count>0){
        if (gesture.direction==UISwipeGestureRecognizerDirectionRight) {
            [self popViewControllerAnimated:YES];
        }
    }
}
//监听触发方法
-(void)themeNotification:(NSNotification *)notification{
    [self loadThemeImage];
}

//加载导航栏的加载图片方法
-(void)loadThemeImage{
        UIImage *image=[[ThemeManager shareInstance]getThemeImage:@"navigationbar_background.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeDidChageNotification object:nil];
}

@end
