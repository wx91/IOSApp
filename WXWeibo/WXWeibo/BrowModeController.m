//
//  BrowModeController.m
//  WXWeibo
//
//  Created by wangx on 15/8/4.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BrowModeController.h"
#import "Constant.h"
@implementation BrowModeController

#pragma mark UI
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.row==0) {
        cell.textLabel.text=@"大图";
        cell.detailTextLabel.text=@"所有网络加载大图";
    }else if (indexPath.row==1){
        cell.textLabel.text=@"小图";
        cell.detailTextLabel.text=@"所有网络加载小图";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int mode=-1;
    if (indexPath.row==0) {
        mode=LargeBrowMode;
    }else if (indexPath.row==1){
        mode=SmallBrowMode;
    }
    //将浏览模式保存到本地
    [[NSUserDefaults standardUserDefaults]setInteger:mode forKey:kBrowMode];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //发送刷新微博列表的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kReloadWeiboTableNotification object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Memory Manager
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
