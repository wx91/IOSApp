//
//  HomeViewController.m
//  CustomWeibo
//
//  Created by wangx on 15/8/9.
//  Copyright (c) 2015年 wangx. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "HomeViewController.h"
#import "Constant.h"
#import "MJExtension.h"
#import "Status.h"
#import "User.h"
#import "UIThemeFactory.h"
#import "MainViewController.h"
#import "DetailViewController.h"

@implementation HomeViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"微博";
        //添加刷新微博的监听
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get) name:kReciveAuthorizeResponse object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    //注销按钮
    UIBarButtonItem *logoutItem=[[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logouAction:)];
    logoutItem.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=logoutItem;
    
    //绑定按钮
    UIBarButtonItem *bindItem=[[UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStylePlain target:self action:@selector(bindAction:)];
    logoutItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem=bindItem;
    
    NSLog(@"rws");
    //初始化tableView
//    _tableView = [[WeiboTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    _tableView.eventDelegate = self;
//    [self.view addSubview:_tableView];
    
    //获取令牌
//    [self Get];
}

#pragma mark instance method
- (void)refreshWeibo{
    //使UI显示下拉
    //    [self.tableView baseTableViewRefreshData];
    //取数据
//    [super showHUD:@"卖力加载中..." isDim:NO];
//    [self pullDownData];
}

#pragma mark -UI Action
- (void)updateUI {
    [UIView animateWithDuration:0.6 animations:^{
        CGRect frame = barView.frame;
        frame.origin.y = 5;
        barView.frame = frame;
    } completion:^(BOOL finished){
        if (finished) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:1.0];
            [UIView setAnimationDuration:0.6];
            CGRect frame = barView.frame;
            frame.origin.y = -120;
            barView.frame = frame;
            [UIView commitAnimations];
        }
    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &soundId);
    AudioServicesPlaySystemSound(soundId);
    //隐藏未读微博的角标
    MainViewController *mainCtrl = (MainViewController *)self.tabBarController;
    [mainCtrl showBadge:NO];
}

- (void)showNewWeiboCount:(int)count{
    if (barView == nil) {
        barView = [UIThemeFactory createImageView:@"timeline_new_status_background.png"];
        UIImage *image = [barView.image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        barView.image = image;
        barView.leftCapWidth = 5;
        barView.topCapHeight = 5;
        barView.frame = CGRectMake(5, -120, ScreenWidth-10, 40);
        [self.view addSubview:barView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 2013;
        label.font = [UIFont systemFontOfSize:16.0f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [barView addSubview:label];
    }
    if (count > 0 ) {
        UILabel *label = (UILabel *)[barView viewWithTag:2013];
        label.text = [NSString stringWithFormat:@"%d条新微博",count];
        [label sizeToFit];
        CGRect frame = label.frame;
        frame.origin = CGPointMake((barView.frame.size.width - frame.size.width)/2, (barView.frame.size.height - frame.size.height)/2);
        label.frame = frame;
        [self performSelector:@selector(updateUI) withObject:nil afterDelay:0.0];
    }
}

#pragma mark - load Data
- (void) loadWeiboData {
    //3875046042956596
    [super showHUD:@"卖力加载中..." isDim:NO];
    NSDictionary *dic=@{@"count":@"5",
                        @"max_id":@"3875046042956596"};
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    [WBHttpRequest requestWithURL:WB_home  httpMethod:@"GET"  params:params delegate:self withTag:@"load"];
}

//下拉加载 /*最新微博*/
- (void)pullDownData{
    if (self.topWeiboId.length == 0) {
        NSLog(@"微博id为空");
        return;
    }
    /*
     * since_id :若指定此参数,则返回ID比since_id大的微博(即比since_id时间晚的微博),默认为0.
     * count:    单页返回的记录条数，最大不超过100, 默认为20;
     */
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"5",@"count",self.topWeiboId,@"since_id",nil];
    [WBHttpRequest requestWithURL:WB_home httpMethod:@"GET" params:params delegate:self withTag:@"pullDown"];
}
//上拉加载  /*最久微博*/
- (void)pullupData{
    if (self.lastWeiboId.length == 0) {
        NSLog(@"微博id为空");
        return;
    }
    /*
     * max_id :若指定此参数,则返回ID小于等于max_id的微博,默认为0.
     * count:    单页返回的记录条数，最大不超过100, 默认为20;
     */
    NSLog(@"%@",self.lastWeiboId);
    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"5",@"count",self.lastWeiboId,@"max_id", nil];
    [WBHttpRequest requestWithAccessToken:[self getToken] url:WB_home httpMethod:@"GET" params:params delegate:self withTag:@"pullUp"];
}

#pragma mark Weibo accessToken
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
        //令牌失效，调用登录方法，使客户重新登录
//        _request = [WBAuthorizeRequest request];
//        _request.redirectURI = kAppRedirectURI;
//        _request.scope = @"all";
//        [WeiboSDK sendRequest:_request];
    }else{
        NSDate *nowDate = [NSDate date];
        if([nowDate compare:[self getExpirationDate]] == NSOrderedAscending){
            //今天比token失效时间小，令牌有效
//            [self loadWeiboData];
        }else{
            //令牌失效，调用登录方法，使客户重新登录
//            _request = [WBAuthorizeRequest request];
//            _request.redirectURI = kAppRedirectURI;
//            _request.scope = @"all";
//            [WeiboSDK sendRequest:_request];
        }
    }
}

#pragma mark - BaseTableViewEventDelegate
//下拉
- (void)pullDown:(BaseTableView *)tableView{
    //请求网络数据
    [self pullDownData];
}
//上拉
- (void)pullUp:(BaseTableView *)tableView{
    [self pullupData];
}
//点击cell
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *modalVC = [[DetailViewController alloc]init];
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    Status *model = [self.weibos objectAtIndex:indexPath.row];
    modalVC.weiboModel = model;
    
//    [self.navigationController presentViewController:modalVC animated:YES completion:nil];
    [self.navigationController pushViewController:modalVC animated:YES];
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
    if([request.tag isEqualToString:@"pullDown"]){
        NSError *error;
        NSDictionary *weiboDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *WeiboInfo = [weiboDIC objectForKey:@"statuses"];
        
        NSMutableArray *weibos = [ NSMutableArray arrayWithCapacity:WeiboInfo.count];
        for (NSDictionary *statuesDic in WeiboInfo) {
            Status *weibo = [Status objectWithKeyValues:statuesDic];
            [weibos addObject:weibo];
        }
        
        if (weibos.count > 0) {
            Status *topWeibo = [weibos objectAtIndex:0];
            self.topWeiboId = [topWeibo.weiboId stringValue];
        }
        self.weibos = weibos;
        self.tableView.data = self.weibos;
        [self.tableView reloadData];
        //显示更新微博数目
        int updateCount = (int)[WeiboInfo count];
        NSLog(@"更新%ld条微博",(long)updateCount);
        [self showNewWeiboCount:updateCount];
        
        [super.hud hide:YES afterDelay:0.5];
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:updateCount inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
    }
    if ([request.tag isEqualToString:@"pullUp"]) {
        NSError *error;
        //首先我需要解析100个json，并保存为字典
        NSDictionary *JSONDIC=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        //2.把所有JSON里面的所有的statuses取出来放在一个字典里面，此时一个statuses代表一份微博数据，
        //注意此时只是原始数据，还不是真正的微博
        
        NSDictionary *statuses=[JSONDIC objectForKey:@"statuses"];
        NSMutableArray *weibos=[NSMutableArray arrayWithCapacity:statuses.count];
        for (NSDictionary *weiboDic in statuses) {
            Status *weibo=[Status objectWithKeyValues:weiboDic];
            NSLog(@"%@",weibo.text);
            [weibos addObject:weibo];
        }
        //移除重复的那一条微博
        [weibos removeObject:[weibos firstObject]];
        if (weibos.count>0) {
            Status *lastWeibo=[weibos lastObject];
            self.lastWeiboId=[lastWeibo.weiboId stringValue];
        }
        [self.weibos addObjectsFromArray:weibos];
        self.tableView.data=self.weibos;
        [self.tableView reloadData];
    }
}
#pragma mark System Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
