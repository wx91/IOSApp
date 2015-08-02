//
//  HomeViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "HomeViewController.h"
#import "Constant.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "WeiboModel.h"
#import "WeiboCell.h"
#import "WeiboView.h"


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
    [self.view addSubview:_tableView];
    
    //检查是否认证
    if (self.sinaweibo.isAuthValid) {
        //加载微博数据
        [self loadWeiboData];
    }
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
#pragma mark load Data
-(void)loadWeiboData{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObject:@"5" forKey:@"count"];
    [self.sinaweibo requestWithURL:@"statuses/friends_timeline.json" params:params httpMethod:@"GET" block:^(id result) {
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
        }
        [self.tableView reloadData];
    }];
}
//下来加载最新微博
-(void)pullDownData{
    if (self.topWeiboId.length==0) {
        NSLog(@"微博ID为空");
        return ;
    }
    
    NSDictionary *dic=@{@"count":@"20",@"since_id":self.topWeiboId};
    NSMutableDictionary *params=[[NSMutableDictionary alloc]initWithDictionary:dic];
    
    [self.sinaweibo requestWithURL:@"statuses/friends_timeline.json" params:params httpMethod:@"GET" block:^(id result) {
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
        NSLog(@"%lu",(unsigned long)uploadcount);
    }];
    
}

#pragma mark  BaseTableView delegate
//下拉调用方法
-(void)pullDown:(BaseTableView *)tableView{
    [self pullDownData];
}
//上拉
-(void)pullUp:(BaseTableView *)tableView{
    
}
//选中一个cell
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



#pragma mark SinaWeiboRequest delegate
////网络加载完成
//- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
//
//}
//网络加载失败
//- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
//    NSLog(@"网络加载失败%@",error);
//}



@end
