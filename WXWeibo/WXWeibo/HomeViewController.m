//
//  HomeViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "HomeViewController.h"
#import "Constant.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "WeiboModel.h"
#import "WeiboCell.h"
#import "WeiboView.h"
#import "UIFactory.h"
#import "ThemeImageView.h"
#import "UIViewExt.h"
#import "Constant.h"
#import "MainViewController.h"
#import "DetailViewController.h"

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
    //注销按钮
    UIBarButtonItem *logoutItem=[[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logouAction:)];
    self.navigationItem.leftBarButtonItem=logoutItem;
    
    //绑定按钮
    UIBarButtonItem *bindItem=[[UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStylePlain target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem=bindItem;
    
    _tableView=[[WeiboTableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight-20-49-44) style:UITableViewStylePlain];
    _tableView.hidden=YES;
    [self.view addSubview:_tableView];
    
    //检查是否认证
    if (self.sinaweibo.isAuthValid) {
        
        //加载微博数据
        [self loadWeiboData];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开启左滑、右滑菜单
    [self.appDelegate.menuCtrl setEnableGesture:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //禁用左滑，右滑
    [self.appDelegate.menuCtrl setEnableGesture:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark-actions
-(void)bindAction:(UIBarButtonItem *)buttonItem{
    [self.sinaweibo logIn];
}

-(void)logouAction:(UIBarButtonItem *)buttonItem{
    [self.sinaweibo logOut];
}

-(void)showNewWeiboCount:(int)count{
    if (barView==nil) {
        barView=[[UIFactory createImageView:@"timeline_new_status_background.png"]retain];
        UIImage *image=[barView.image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        barView.image=image;
        barView.leftCapWidth=5;
        barView.topCapHeight=5;
        barView.frame=CGRectMake(5, -40, ScreenWidth-10, 40);
        [self.view addSubview:barView];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectZero];
        label.tag=2013;
        label.font=[UIFont systemFontOfSize:16.0f];
        label.textColor=[UIColor whiteColor];
        label.backgroundColor=[UIColor clearColor];
        [barView addSubview:label];
    }
    if (count>0) {
        UILabel *label=(UILabel *)[barView viewWithTag:2013];
        label.text=[NSString stringWithFormat:@"%d条新微博",count];
        [label sizeToFit];
        label.origin=CGPointMake((barView.width-label.width)/2, (barView.height-label.height)/2);
        [UIView animateWithDuration:0.6 animations:^{
            barView.top=5;
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDelay:1];
                [UIView setAnimationDuration:0.6];
                barView.top=-40;
                [UIView commitAnimations];
            }
        }];
        //播放系统提示声音
        NSString *filePath=[[NSBundle mainBundle]pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url=[NSURL fileURLWithPath:filePath];
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID((CFURLRef)url,&soundId);
        AudioServicesPlayAlertSound(soundId);
    }
    //隐藏未读图标
    MainViewController *mainCtrl=(MainViewController *)self.tabBarController;
    [mainCtrl showBadge:NO];
}

#pragma mark load Data
-(void)loadWeiboData{
    //显示加载提示
    [super showLoading:YES];
    [super showHUD:@"正在加载中..." isDim:YES];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObject:@"5" forKey:@"count"];
//    [self.sinaweibo requestWithURL:@"statuses/friends_timeline.json" params:params httpMethod:@"GET" block:^(id result) {
//
//    }];
    [self.sinaweibo requestWithURL:@"statuses/friends_timeline.json" params:params httpMethod:@"GET" delegate:self];

}

//下来加载最新微博
-(void)pullDownData{
    if (self.topWeiboId.length==0) {
        NSLog(@"微博ID为空");
        return ;
    }
    /**
     since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
     count	false	int	单页返回的记录条数，最大不超过100，默认为20。
     **/
    NSDictionary *dic=@{@"count":@"20",@"since_id":self.topWeiboId};
    NSMutableDictionary *params=[[NSMutableDictionary alloc]initWithDictionary:dic];
    [self.sinaweibo requestWithURL:@"statuses/friends_timeline.json" params:params httpMethod:@"GET" block:^(id result) {
        [self pullDownDataFinish:result];
    }];
}
//下来完成
-(void)pullDownDataFinish:(id)result{
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statuesDic in statues) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        NSLog(@"%@",weibo);
        [array addObject:weibo];
    }
    //更新topid
    if(array.count>0){
        WeiboModel *topWeibo=[array objectAtIndex:0];
        self.topWeiboId=[topWeibo.weiboId stringValue];
    }
    
    [array addObjectsFromArray:self.weibos];
    self.weibos=array;
    self.tableView.data=array;
    
    [self.tableView reloadData];
    [self.tableView doneLoadingTableViewData];
    NSUInteger uploadcount=[statues count];
    NSLog(@"%lul",(unsigned long)uploadcount);
}

#pragma mark  BaseTableView delegate
//下拉调用方法
-(void)pullDown:(BaseTableView *)tableView{
    [self pullDownData];
}
//上拉
-(void)pullUp:(BaseTableView *)tableView{
    [self pullUpData];
}
//选中一个cell
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboModel *weibo=[self.weibos objectAtIndex:indexPath.row];
    DetailViewController *detail=[[DetailViewController alloc]init];
    detail.weiboModel=weibo;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)refreshWeibo{
    //使UI显示下来
    [self.tableView refreshData];
    //加载数据
    [self pullDownData];
}


#pragma mark SinaWeiboRequest delegate
//网络加载完成
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statuesDic in statues) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        NSLog(@"%@",weibo);
        [weibos addObject:weibo];
    }
    self.tableView.data=weibos;
    self.weibos=weibos;
    if (weibos.count>0) {
        WeiboModel *topWeibo=[weibos objectAtIndex:0];
        self.topWeiboId=[topWeibo.weiboId stringValue];
        
        WeiboModel *lastWeibo=[weibos lastObject];
        self.lastWeiboId=[lastWeibo.weiboId stringValue];
    }
    [self.tableView reloadData];
    self.tableView.hidden=NO;
}
//网络加载失败
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"网络加载失败%@",error);
}


-(void)pullUpData{
    if (self.lastWeiboId.length==0) {
        NSLog(@"微博ID为空");
        return ;
    }
    /**
     max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
     count	false	int	单页返回的记录条数，最大不超过100，默认为20。
     **/
    NSDictionary *dic=@{@"count":@"20",@"max_id":self.lastWeiboId};
    NSMutableDictionary *params=[[NSMutableDictionary alloc]initWithDictionary:dic];
    [self.sinaweibo requestWithURL:@"statuses/friends_timeline.json" params:params httpMethod:@"GET" block:^(id result) {
        [self pullUpDataFinish:result];
    }];
}
-(void)pullUpDataFinish:(id)result{
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statuesDic in statues) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        NSLog(@"%@",weibo);
        [array addObject:weibo];
    }
    //更新lastWeiboId
    if(array.count>0){
        WeiboModel *lastWeibo=[array lastObject];
        self.lastWeiboId=[lastWeibo.weiboId stringValue];
    }
    //刷新UI
    if (statues.count>=20) {
        self.tableView.isMore=YES;
    }else{
        self.tableView.isMore=NO;
    }
    
    [array addObjectsFromArray:self.weibos];
    self.weibos=array;
    self.tableView.data=array;
    
    [self.tableView reloadData];
}
@end
