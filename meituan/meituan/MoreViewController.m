//
//  MoreViewController.m
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "MoreViewController.h"
#import "Constant.h"
#import "HotQueueViewController.h"

@implementation MoreViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //解析plist文件，获取数据
    NSString *plistPath=[[NSBundle mainBundle]pathForResource:@"MoreData" ofType:@"plist"];
    data=[[NSMutableArray alloc]initWithContentsOfFile:plistPath];
}
#pragma mark UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 5;
    }else if (section==2){
        return 5;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indetifier=@"MoreCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indetifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifier];
    }
    cell.textLabel.text=[data[indexPath.section] objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize:15.0];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        if (indexPath.row==1) {
            //支付帮助
            NSString *urlStr = @"http://i.meituan.com/help/pay?f=ios&ci=1&lat=39.98345504672791&lng=116.3180332149903&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-07-09-47438&token=p19ukJltGhla4y5Jryb1jgCdKjsAAAAAsgAAADHFD3UYGxaY2FlFPQXQj2wCyCrhhn7VVB-KpG_U3-clHlvsLM8JRrnZK35y8UU3DQ&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___ab_pindaoshenyang__a__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_waimaiwending__a__a___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___i_group_5_2_deallist_poitype__d__d___ab_i_group_5_3_poidetaildeallist__a__b___ab_pindaoquxincelue0630__b__b1___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___b1junglehomepagecatesort__b__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGmore&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
            HotQueueViewController *webVC=[[HotQueueViewController alloc]init];
            webVC.urlStr=urlStr;
            [self.navigationController pushViewController:webVC animated:YES];
        }else if (indexPath.row==4){
            //我要应聘
            NSString *urlStr = @"http://i.meituan.com/help/jobs?ci=1&f=iphone&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-07-09-47438&token=p19ukJltGhla4y5Jryb1jgCdKjsAAAAAsgAAADHFD3UYGxaY2FlFPQXQj2wCyCrhhn7VVB-KpG_U3-clHlvsLM8JRrnZK35y8UU3DQ&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___ab_pindaoshenyang__a__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_waimaiwending__a__a___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___i_group_5_2_deallist_poitype__d__d___ab_i_group_5_3_poidetaildeallist__a__b___ab_pindaoquxincelue0630__b__b1___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___b1junglehomepagecatesort__b__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGmore&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7&lat=39.98345504672791&lng=116.3180332149903";
            HotQueueViewController *webVC = [[HotQueueViewController alloc] init];
            webVC.urlStr = urlStr;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
}

#pragma mark Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
