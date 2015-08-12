//
//  DetailViewController.m
//  CustomWeibo
//
//  Created by wangx on 15/8/11.
//  Copyright (c) 2015年 wangx. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "UIViewExt.h"
#import "Comment.h"
#import "MJExtension.h"
#import "UIUtils.h"

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self loadData];
}

-(void)initView{
    
    //初始化tableView
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    
    //---------------用户栏视图---------------
    self.userImageView=[[UIImageView alloc]init];
    self.userImageView.layer.cornerRadius  = 5;
    self.userImageView.layer.borderWidth   = 0.2;
    self.userImageView.layer.masksToBounds = YES;
    NSString *userImageURL =  _weiboModel.user.profile_image_url;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:userImageURL]];
    self.userImageView.frame=CGRectMake(5, 5, 40, 40);
    [tableHeaderView addSubview:self.userImageView];
    //昵称
    self.nickLabel=[[UILabel alloc]init];
    self.timeLabel.font=[UIFont systemFontOfSize:14.0];
    self.nickLabel.text = _weiboModel.user.screen_name;
    self.nickLabel.frame= CGRectMake(50, 5, 160, 20);
    [tableHeaderView addSubview:self.nickLabel];
    
    self.timeLabel=[[UILabel alloc]init];
    self.timeLabel.font=[UIFont systemFontOfSize:12.0];
    self.timeLabel.text=[UIUtils fomateString:_weiboModel.createDate];
    self.timeLabel.frame= CGRectMake(_userImageView.right+5,_nickLabel.bottom, 80, 20);
    [tableHeaderView addSubview:self.timeLabel];
    
    tableHeaderView.height += 60;
    
    //-------------创建微博视图--------------
    float h = [WeiboView getWeiboViewHeight:self.weiboModel isDetail:YES isRepost:NO];
    _weiboView = [[WeiboView alloc]initWithFrame:CGRectMake(10, _timeLabel.bottom + 10, ScreenWidth - 20, h)];
    _weiboView.isDetail = YES;
    _weiboView.weiboModel = _weiboModel;
    [tableHeaderView addSubview:_weiboView];
    tableHeaderView.height += (h +30);
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.eventDelegate = self;
}

- (NSString *)getToken
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"WeiboAuthData"] objectForKey:@"accessToken"];
}


- (void)loadData{
    NSString *weiboID = [_weiboModel.weiboId stringValue];
    if (weiboID.length == 0) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:weiboID,@"id",@"20",@"count",nil];
    [WBHttpRequest requestWithAccessToken:[self getToken] url:WB_Comments httpMethod:@"GET" params:params delegate:self withTag:@"comment"];
}
#pragma mark UITableViewEventDelegate
//上拉
- (void)pullUp:(BaseTableView *)tableView{
    NSString *weiboID = [_weiboModel.weiboId stringValue];
    if (weiboID.length == 0) {
        return;
    }
    NSDictionary *params=@{@"count":@"5",
                           @"max_id":self.lastWeiboID
                           };
    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:weiboID,@"id",@"5",@"count",self.lastWeiboID,@"max_id",nil];
    [WBHttpRequest requestWithAccessToken:[self getToken] url:WB_Comments httpMethod:@"GET" params:params delegate:self withTag:@"pullUp"];
}

-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - WBHttpRequest Delegate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    if ([request.tag isEqual:@"comment"]) {
        NSError *error;
        NSDictionary *JSONDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        self.tableView.totalCommentNumber =  [JSONDIC objectForKey:@"total_number"];
        NSDictionary *commentsDic = [JSONDIC objectForKey:@"comments"];
        NSMutableArray *comments = [NSMutableArray arrayWithCapacity:commentsDic.count];
        for (NSDictionary *dic in commentsDic) {
            Comment *commentModel = [Comment objectWithKeyValues:dic];
            [comments addObject:commentModel];
        }
        self.tableView.data = self.comments;
        self.comments = comments;
        if (commentsDic.count > 0) {
            Comment *commentModel = [comments lastObject];
            self.lastWeiboID = [commentModel.commentId stringValue];
        }
        //刷新tableView
        [self.tableView reloadData];
    }

    if ([request.tag isEqual:@"pullUp"]) {
        NSError *error;
        NSDictionary *JSONDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *commentsDic = [JSONDIC objectForKey:@"comments"];
        NSMutableArray *comments = [NSMutableArray arrayWithCapacity:commentsDic.count];
        for (NSDictionary *dic in commentsDic) {
            Comment *commentModel = [Comment objectWithKeyValues:dic];
            [comments addObject:commentModel];
        }
        if (comments.count > 0) {
            Comment *commentModel = [comments lastObject];
            self.lastWeiboID = [commentModel.commentId stringValue];
        }
        [self.comments addObjectsFromArray:comments];
        NSLog(@"%lu",(unsigned long)self.comments.count);
        self.tableView.data = self.comments;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
