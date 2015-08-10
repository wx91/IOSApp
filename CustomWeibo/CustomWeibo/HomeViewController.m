//
//  HomeViewController.m
//  CustomWeibo
//
//  Created by wangx on 15/8/9.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "HomeViewController.h"
#import "Constant.h"
#import "MJExtension.h"
#import "Status.h"
#import "User.h"

@implementation HomeViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"微博";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //减去状态栏20 49 的toolbar 49 的navigation
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49-49-20)];
    //注销按钮
    UIBarButtonItem *logoutItem=[[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logouAction:)];
    self.navigationItem.leftBarButtonItem=logoutItem;
    
    //绑定按钮
    UIBarButtonItem *bindItem=[[UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStylePlain target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem=bindItem;
    
    //获取令牌
    [self Get];
    
    //初始化tableView
    _tableView = [[WeiboTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    _tableView.eventDelegate = self;
//    _tableView.hidden = YES;
    [self.view addSubview:_tableView];

}

#pragma mark-actions
-(void)bindAction:(UIBarButtonItem *)buttonItem{
    _request = [WBAuthorizeRequest request];
    _request.redirectURI = kAppRedirectURI;
    _request.scope = @"all";
    [WeiboSDK sendRequest:_request];
}

-(void)logouAction:(UIBarButtonItem *)buttonItem{
    [WeiboSDK logOutWithToken:[self getToken] delegate:nil withTag:@"user1"];
}

//调用accessToken和ExpirationDate
- (NSString *)getToken
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"WeiboAuthData"] objectForKey:@"accessToken"];
}
- (NSDate *)getExpirationDate
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"WeiboAuthData"] objectForKey:@"expirationDate"];
}

//获取微博
- (void)Get{
    if ([self getToken] == nil || [[self getToken] isEqualToString:@""]) {
        NSLog(@"令牌是失效!");
    }else{
        NSDate *nowDate = [NSDate date];
        if([nowDate compare:[self getExpirationDate]] == NSOrderedAscending){
            //今天比token失效时间小，令牌有效
            [self loadWeiboData];
        }else{
            //令牌失效
        }
    }
}

#pragma mark - load Data
- (void) loadWeiboData {
    [super showHUD:@"卖力加载中..." isDim:NO];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"5" forKey:@"count"];
    [WBHttpRequest requestWithAccessToken:[self getToken] url:WB_home  httpMethod:@"GET" params:params delegate:self withTag:@"load"];
}
#pragma mark  - WBHttpRequestDelegate
//网络加载完成
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    //--------------------load----------------------------
    if ([request.tag isEqual:@"load"]) {
        [super.hud hide:YES afterDelay:0];
        NSError *error;
        NSDictionary *weiboDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *WeiboInfo = [weiboDIC objectForKey:@"statuses"];
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:WeiboInfo.count];
        for (NSDictionary *statuesDic in WeiboInfo) {
            Status *weibo = [Status objectWithKeyValues:statuesDic];
            NSLog(@"%@",weibo.user.screen_name);
            [weibos addObject:weibo];
        }
        self.tableView.data = weibos;
        self.weibos = weibos;
        if (weibos.count > 0) {
            //记下最新的微博ID
            Status *topWeibo= [weibos objectAtIndex:0];     //取出最新的一条微博
            self.topWeiboId = [topWeibo.weiboId stringValue];   //把最新的微博ID赋值给我们定义的这个topWeiboId变量
            //同理，记下最久的微博ID
            Status *lastWeibo = [weibos lastObject];  //取出最久的一条微博
            self.lastWeiboId = [lastWeibo.weiboId stringValue];//把最久的微博ID复制给我们定义的这个lastWeiboId变量
        }
        //刷新tableView
        [_tableView reloadData];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
