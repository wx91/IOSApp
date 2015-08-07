//
//  DetailViewController.m
//  WXWeibo
//
//  Created by wangx on 15/8/4.
//  Copyright (c) 2015年 wangx. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "Constant.h"
#import "UIViewExt.h"
#import "CommentModel.h"
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
//创建子视图
-(void)initView{
    UIView *tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, 0)];
    tableHeaderView.backgroundColor=[UIColor clearColor];
    
    NSString *userImageurl=_weiboModel.user.profile_image_url;
    self.userImageView.layer.cornerRadius=5;
    self.userImageView.layer.masksToBounds=YES;
    [self.userImageView setImageWithURL:[NSURL URLWithString:userImageurl]];
    
    self.nickLabel.text=_weiboModel.user.screen_name;
    [tableHeaderView addSubview:self.userBarView];
    tableHeaderView.height+=60;
    
    //创建微博视图
//    float h=[WeiboView getWeiboViewHeight:self.weiboModel isRepost:NO isDetail:YES];
//    _weiboView =[[WeiboView alloc]initWithFrame:CGRectMake(10, _userBarView.bottom+10, ScreenWidth-20, h)];
//    _weiboView.isDetail=YES;
//    _weiboView.weiboModel=_weiboModel;
//    [tableHeaderView addSubview:_weiboView];
//    tableHeaderView.height+=(h+10);
    self.tableView.tableHeaderView=tableHeaderView;
    self.tableView.eventDelegate=self;
}


-(void)loadData{
    NSString *weiboId=[_weiboModel.weiboId stringValue];
    if (weiboId.length==0) {
        return;
    }
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObject:weiboId forKey:@"id"];
    [self.sinaweibo requestWithURL:@"comments/show.json" params:params httpMethod:@"FET" block:^(id result) {
            [self loadDataFinish:result];
    }];
}

-(void)loadDataFinish:(id)result{
    NSArray *array=[result objectForKey:@"comments"];
    NSMutableArray *comments=[NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in comments) {
        CommentModel *commentModel=[[CommentModel alloc]initWithDataDic:dic];
        [comments addObject:commentModel];
    }
    if (array.count>=20) {
        self.tableView.isMore=YES;
    }else{
        self.tableView.isMore=NO;
    }
    
    self.tableView.data=comments;
    self.tableView.commentDic=result;
    [self.tableView reloadData];
}
#pragma mark UITableViewEventDelegate
//下拉调用方法
-(void)pullDown:(BaseTableView *)tableView{
    
}
//上拉
-(void)pullUp:(BaseTableView *)tableView{
    
}
//选中一个cell
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_tableView release];
    [_userImageView release];
    [_nickLabel release];
    [_userBarView release];
    [super dealloc];
}
@end
