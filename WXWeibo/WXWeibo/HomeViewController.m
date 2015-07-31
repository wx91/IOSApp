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

@interface HomeViewController ()

@end

@implementation HomeViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"首页";
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
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObject:@"2" forKey:@"count"];
    [self.sinaweibo requestWithURL:@"statuses/friends_timeline.json" params:params httpMethod:@"GET" delegate:self];
    
}
#pragma mark SinaWeiboRequest delegate
//网络加载完成
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    NSArray *statuses=[result objectForKey:@"statuses"];
    NSMutableArray *weibos=[NSMutableArray array];
    for (NSDictionary *statuesDic in statuses) {
        WeiboModel *weibo=[[WeiboModel alloc]initWithDataDic:statuesDic];
        [weibos addObject:weibo];
    }
    NSLog(@"------%@",weibos);
}
//网络加载失败
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"网络加载失败%@",error);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
