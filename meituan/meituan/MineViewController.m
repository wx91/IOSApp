//
//  MineViewController.m
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "MineViewController.h"
#import "Constant.h"

@implementation MineViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initData];
}

-(void)initData{
    data=[NSMutableArray array];
    NSArray *titles=@[@"团购订单",@"预定订单",@"上门订单",@"我的评价",@"每日推荐",@"会员俱乐部",@"我的抽奖",@"我的抵用券"];
    for (int i=0; i<titles.count; i++) {
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        NSString *title=[titles objectAtIndex:i];
        [dic setObject:title forKey:@"title"];
        [dic setObject:@"icon_mine_onsite" forKey:@"image"];
        [data addObject:dic];
    }
}

#pragma mark -UITableView Delegate
//设置tableview中有几节
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//设置每节中的row个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 8;
    }
}
//设置节头的自定义视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
        headerView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_login"]];
        //头像
        UIImageView *userImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 55, 55)];
        userImage.layer.masksToBounds=YES;
        userImage.layer.cornerRadius=27;
        [userImage setImage:[UIImage imageNamed:@"icon_mine_default_portrait"]];
        [headerView addSubview:userImage];
        
        //用户名
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+55+5, 15, 200, 30)];
        userNameLabel.font = [UIFont systemFontOfSize:13];
        userNameLabel.text = @"波雅.汉库克";
        [headerView addSubview:userNameLabel];
        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+55+5, 40, 200, 30)];
        moneyLabel.font = [UIFont systemFontOfSize:13];
        moneyLabel.text = @"账户余额：0.00元";
        [headerView addSubview:moneyLabel];
        
        return headerView;
    }else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
        headerView.backgroundColor = RGB(239, 239, 244);
        return headerView;
    }
}
//设置节头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 75;
    }else{
        return 5;
    }
}
//设置节尾的自定义视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_height, 75)];
    footerView.backgroundColor = RGB(239, 239, 244);
    return footerView;
}
//设置节尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
//设置tableview cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Indentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Indentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
    }
    if (indexPath.section==1) {
        cell.textLabel.text=[data[indexPath.row] objectForKey:@"title"];
        NSString *image=[data[indexPath.row] objectForKey:@"image"];
        cell.imageView.image=[UIImage imageNamed:image];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }else{
        cell.textLabel.text=@"我的标题";
        cell.selectionStyle=UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
//设置没有row的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 60;
    }else{
        return 40;
    }
}

@end
