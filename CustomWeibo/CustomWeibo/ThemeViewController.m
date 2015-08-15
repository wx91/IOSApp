//
//  ThemeViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/29.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"
#import "UIThemeFactory.h"
#import "Constant.h"

@implementation ThemeViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"主题切换";
        themes=[[ThemeManager shareInstance].themePlist allKeys];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [themes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"themeCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UILabel *textLabel =[UIThemeFactory createLabel:kThemeListLabel];
        textLabel.frame=CGRectMake(10, 10, 200, 30);
        textLabel.backgroundColor=[UIColor clearColor];
        textLabel.font=[UIFont boldSystemFontOfSize:16.0f];
        textLabel.tag=2013;
        [cell.contentView addSubview:textLabel];
    }
    UILabel *textLabel=(UILabel *)[cell.contentView viewWithTag:2013];
    NSString *name=themes[indexPath.row];
    textLabel.text=name;
    NSString *themeName=[ThemeManager shareInstance].themeName;
    if (themeName==nil) {
        themeName=@"默认";
    }
    if ([themeName isEqualToString:name]) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *themeName=themes[indexPath.row];
    if ([themeName isEqualToString:@"默认"]) {
        themeName=nil;
    }
    //保存主题到本地
    [[NSUserDefaults standardUserDefaults]setObject:themeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [ThemeManager shareInstance].themeName=themeName;
    [[NSNotificationCenter defaultCenter]postNotificationName:kThemeDidChageNotification object:themeName];
    //刷新列表
    [tableView reloadData];
}

#pragma mark System Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
