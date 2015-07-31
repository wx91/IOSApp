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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
