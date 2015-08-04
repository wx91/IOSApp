//
//  BaseViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "UIFactory.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "UIViewExt.h"

@interface BaseViewController ()

@end

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
//       UIButton *button=[UIFactory createButton:@"navigationbar_back.png" highligted:@"navigationbar_back.png"];
        UIButton *button=[UIFactory createButtonWithBackground:@"navigationbar_back.png" backgroundHighligted:@"navigationbar_back.png"];
        button.showsTouchWhenHighlighted=YES;
        button.frame=CGRectMake(0, 0, 24, 24);
        [button  addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        self.navigationItem.leftBarButtonItem=backItem;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark
-(SinaWeibo *)sinaweibo{
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo=appdelegate.sinaweibo;
    return sinaweibo;
}

-(AppDelegate *)appDelegate{
    AppDelegate *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
//    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
//    titleLabel.textColor=[UIColor blackColor];
    UILabel *titleLabel=[UIFactory createLabel:kNavigationBarTitleLabel];
    titleLabel.font=[UIFont boldSystemFontOfSize:18];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView=titleLabel;
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showLoading:(BOOL )show{
    if (_loadView==nil) {
        _loadView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2-80, ScreenWidth, 20)];
        //loading视图
        UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        
        //正在加载的Label
        UILabel *loadLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        loadLabel.backgroundColor=[UIColor clearColor];
        loadLabel.text=@"正在加载...";
        loadLabel.font=[UIFont boldSystemFontOfSize:16.0f];
        loadLabel.textColor=[UIColor blackColor];
        [loadLabel sizeToFit];
        
        loadLabel.left=(320-loadLabel.width)/2;
        activityView.right=loadLabel.left-5;
        [_loadView addSubview:loadLabel];
        [_loadView addSubview:activityView];
    }
    if (show) {
        if (![_loadView superview]) {
            [self.view addSubview:_loadView];
        }
    }else{
        [_loadView removeFromSuperview];
    }
}

-(void)showHUD:(NSString *)title isDim:(BOOL)isDim{
    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground=isDim;
    self.hud.labelText=title;
}

-(void)showHUDComplete:(NSString *)title{
    self.hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    self.hud.mode=MBProgressHUDModeCustomView;
    if (title.length>0) {
        self.hud.labelText=title;
    }
    [self.hud hide:YES afterDelay:1];
}

-(void)hideHUD{
    [self.hud hide:YES];
}

@end
