//
//  RightViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "RightViewController.h"
#import "BaseNavigationViewController.h"
#import "SendViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor darkGrayColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)sendAction:(UIButton *)sender {
    if (sender.tag==100) {
        SendViewController *sendCtrl=[[SendViewController alloc]init];
        BaseNavigationViewController *sendNav=[[BaseNavigationViewController alloc]initWithRootViewController:sendCtrl];
//        [self presentViewController:sendNav animated:YES completion:NULL];
        [self.appDelegate.menuCtrl presentViewController:sendNav animated:YES completion:NULL];
//        [self.appDelegate.mainCtrl.navigationController pushViewController:sendNav animated:YES];
        
        
    }
}
@end
