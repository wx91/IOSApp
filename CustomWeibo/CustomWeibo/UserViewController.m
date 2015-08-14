//
//  UserViewController.m
//  CustomWeibo
//
//  Created by wangx on 15/8/12.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoView.h"
#import "Constant.h"
#import "DetailViewController.h"
#import "Status.h"
#import "User.h"
#import "MJExtension.h"

@interface UserViewController ()

@end

@implementation UserViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"个人资料";
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UserInfoView *userInfo=[[UserInfoView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    self.tableView.tableHeaderView=userInfo;
    [self loadUserData];
    [self loadUserWeibo];
}
- (NSString *)getToken{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"WeiboAuthData"] objectForKey:@"accessToken"];
}
#pragma mark --加载用户信息
-(void)loadUserData{
    if (self.userName.length==0&&self.userid.length==0) {
        NSLog(@"error:用户昵称为空!");
        return ;
    }
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    if (self.userid.length!=0) {
        [params setObject:self.userid forKey:@"uid"];
    }else{
        [params setObject:self.userName forKey:@"screen_name"];
    }
    [WBHttpRequest requestWithURL:WB_loadUserData httpMethod:@"GET" params:params delegate:self withTag:@"loadUserData"];
}

//获取当前用户的所有微博
- (void)loadUserWeibo{
    if (self.userName.length == 0 && self.userid.length == 0) {
        NSLog(@"error:用户名称为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.userid.length != 0) {
        [params setObject:self.userid forKey:@"uid"];
    }else{
        [params setObject:self.userName forKey:@"screen_name"];
    }
    [WBHttpRequest requestWithAccessToken:[self getToken] url:WB_loadUserWeibo httpMethod:@"GET" params:params delegate:self withTag:@"loadUserWeibo"];
}

#pragma mark - WBHttpRequest
//网络加载完成
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    
    //-------------------loadUserData----------------------------
    if ([request.tag isEqual:@"loadUserData"]) {
        NSError *error;
        NSDictionary *userDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        User *userModel = [User objectWithKeyValues:userDIC];
        self.userInfoView.user = userModel;
        self.tableView.tableHeaderView = _userInfoView;
    }else if([request.tag isEqual:@"loadUserWeibo"]){
        NSError *error;
        NSDictionary *userWeiboDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *userWeiboInfo = [userWeiboDIC objectForKey:@"statuses"];
        
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:userWeiboInfo.count];
        
        for (NSDictionary *statuesDic in userWeiboInfo) {
            Status *weibo = [Status objectWithKeyValues:statuesDic];
            [weibos addObject:weibo];
            
        }
        if (weibos.count > 0) {
            Status *topWeibo= [weibos objectAtIndex:0];     //取出最新的一条微博
            self.topWeiboId = [topWeibo.weiboId stringValue];   //把最新的微博ID赋值给我们定义的这个topWeiboId变量
            //同理，记下最久的微博ID
            Status *lastWeibo = [weibos lastObject];  //取出最久的一条微博
            self.lastWeiboId = [lastWeibo.weiboId stringValue];//把最久的微博ID复制给我们定义的这个lastWeiboId变量
        }
        self.tableView.data = weibos;
        self.weibos = weibos;
        [self.tableView reloadData];
    }
    //-------------------pullDown----------------------------
    if ([request.tag isEqual:@"pullDown"]) {
        NSError *error;
        NSDictionary *WeiboDIC  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *WeiboInfo = [WeiboDIC objectForKey:@"statuses"];
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:WeiboInfo.count];
        for (NSDictionary *dic in WeiboInfo) {
            Status *weiboModel = [Status objectWithKeyValues:dic];
            [weibos addObject:weiboModel];
        }
        if (weibos.count > 0 ) {
            Status *weiboModel = [weibos firstObject];
            self.topWeiboId = [weiboModel.weiboId stringValue];
        }
        [weibos addObjectsFromArray:self.weibos];
        self.weibos = weibos;
        self.tableView.data = self.weibos;
        [self.tableView reloadData];
    }
    //----------------------pullUp-----------------------------
    if ([request.tag isEqual:@"pullUp"]) {
        NSError *error;
        //首先我需要解析这100个json，并保存为字典
        NSDictionary *JSONDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *statuses = [JSONDIC objectForKey:@"statuses"];
        NSLog(@"%@",statuses);
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statuses.count];
        for (NSDictionary *dic in statuses) {
            Status *weibo = [Status objectWithKeyValues:dic];
            [weibos addObject:weibo];
        }
        if (weibos.count > 0) {
            Status *lastWeibo = [weibos lastObject];
            self.lastWeiboId = [lastWeibo.weiboId stringValue];
        }
        [self.weibos addObjectsFromArray:weibos];
        self.tableView.data = self.weibos;
        //判断剩余是否大于一页
        if (statuses.count >= 25) {
#warning 判断是否有下一页
//            self.tableView.
        }else {
#warning 判断是否有下一页
//            self.tableView.isMore = NO;
        }
        [self.tableView reloadData];
    }
}

#pragma mark -  UITableViewEventDelegate
//下拉
- (void)pullDown:(BaseTableView *)tableView{
    
    if(self.topWeiboId.length == 0){
        NSLog(@"微博ID为空");
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"20",@"count",self.topWeiboId,@"since_id",nil];
    [WBHttpRequest requestWithURL:WB_loadUserWeibo httpMethod:@"GET" params:params delegate:self withTag:@"pullDown"];
    
}

//上拉
- (void)pullUp:(BaseTableView *)tableView{
    if (self.lastWeiboId.length == 0) {
        NSLog(@"微博id为空");
        return;
    }
    
    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"25",@"count",self.lastWeiboId,@"max_id",self.userName,@"screen_name", nil];
    [WBHttpRequest requestWithURL:WB_loadUserWeibo httpMethod:@"GET" params:params delegate:self withTag:@"pullUp"];
}

//选中cell
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *modalView = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:modalView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
