//
//  BaseViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "UIThemeFactory.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "UIViewExt.h"

@implementation BaseViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *viewController=self.navigationController.viewControllers;
    if (viewController.count>1&&self.isBackButton) {
        UIButton *button=[UIThemeFactory createButtonWithBackground:@"navigationbar_back.png" backgroundHighligted:@"navigationbar_back.png"];
        button.showsTouchWhenHighlighted=YES;
        button.frame=CGRectMake(0, 0, 24, 24);
        [button  addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        self.navigationItem.leftBarButtonItem=backItem;

    }
}
//点击方法按钮触发方法
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(AppDelegate *)appDelegate{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

//复父类中的方法
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    UILabel *titleLabel=[UIThemeFactory createLabel:kNavigationBarTitleLabel];
    titleLabel.font=[UIFont boldSystemFontOfSize:18];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView=titleLabel;
}

//使用框架进行加载提示
-(void)showHUD:(NSString *)title isDim:(BOOL)isDim{
    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground=isDim;
    self.hud.labelText=title;
}
//使用框架进行完成提示
-(void)showHUDComplete:(NSString *)title{
    self.hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    self.hud.mode=MBProgressHUDModeCustomView;
    if (title.length>0) {
        self.hud.labelText=title;
    }
    [self.hud hide:YES afterDelay:1];
}
//隐藏提示
-(void)hideHUD{
    [self.hud hide:YES];
}

-(void)showStatusTip:(BOOL)show title:(NSString *)title{
    if (tipWindow == nil) {
        tipWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        tipWindow.windowLevel = UIWindowLevelStatusBar;
        tipWindow.backgroundColor = [UIColor blackColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 2014;
        [tipWindow addSubview:label];
        
        UIImageView *progress = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"queue_statusbar_progress.png"]];
        progress.frame = CGRectMake(0, 20-6, 100, 6);
        progress.tag = 2013;
        [tipWindow addSubview:progress];
    }
    UILabel *label = (UILabel *)[tipWindow viewWithTag:2014];
    UIImageView *progress = (UIImageView *)[tipWindow viewWithTag:2013];
    
    if (show) {
        label.text = title;
        tipWindow.hidden = NO;
        //发送进度的动画
        progress.left = 0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationRepeatCount:1000];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];//匀速移动
        progress.left = ScreenWidth;
        [UIView commitAnimations];
    }else{
        progress.hidden = YES;
        label.text = title;
        [self performSelector:@selector(removeTipWindow) withObject:nil  afterDelay:1.5];
    }
}

-(void)multipleValue:(NSArray *)array{
    [self showStatusTip:[array firstObject] title:[array lastObject]];
}

-(void) removeTipWindow{
    tipWindow.hidden = YES;
    tipWindow = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
