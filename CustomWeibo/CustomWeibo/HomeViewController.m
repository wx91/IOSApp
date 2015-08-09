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
    
    //注销按钮
    UIBarButtonItem *logoutItem=[[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logouAction:)];
    self.navigationItem.leftBarButtonItem=logoutItem;
    
    //绑定按钮
    UIBarButtonItem *bindItem=[[UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStylePlain target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem=bindItem;
    
    [self Get];
    
}

#pragma mark-actions
-(void)bindAction:(UIBarButtonItem *)buttonItem{
    _request = [WBAuthorizeRequest request];
    _request.redirectURI = kAppRedirectURI;
    _request.scope = @"all";
//    _request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                          @"Other_Info_1": [NSNumber numberWithInt:123],
//                          @"Other_Info_2": @[@"obj1", @"obj2"],
//                          @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
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
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"1" forKey:@"count"];
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
//            Status *status=[[Status alloc]initWithDataDic:statuesDic];
//            NSLog(@"%@",statuesDic);
            Status *status=[Status objectWithKeyValues:statuesDic];
            NSLog(@"%@",status.text);
            NSLog(@"%@",status.user);
            NSLog(@"%@",status.user.screen_name);
            [weibos addObject:status];
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
