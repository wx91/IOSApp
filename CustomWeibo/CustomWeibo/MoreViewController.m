//
//  MoreViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "MoreViewController.h"
#import "ThemeViewController.h"
#import "BrowseModeController.h"

@implementation MoreViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"更多";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.row==0) {
        cell.textLabel.text=@"主题";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"浏览模式";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        ThemeViewController *themeCtrl=[[ThemeViewController alloc]init];
        [self.navigationController pushViewController:themeCtrl animated:YES];
    }else if (indexPath.row == 1){
        BrowseModeController *view = [[BrowseModeController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    }
}


@end
