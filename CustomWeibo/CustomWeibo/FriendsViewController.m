//
//  FriendsViewController.m
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "FriendsViewController.h"
#import "User.h"
#import "Constant.h"
#import "UIViewExt.h"
#import "MJExtension.h"


@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data=[NSMutableArray array];
    self.tableView.eventDelegate=self;
    
    if (self.friendType==Fans) {
        self.title=@"粉丝数";
        
    }else{
        self.title=@"关注数";
        
    }
}

-(void)loadData:(NSString *)url{
    if (self.userName.length==0) {
        NSLog(@"用户ID不为空");
        return ;
    }
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.userName,@"screen_name", nil];
    if (self.cursor.length>0) {
        [params setObject:self.cursor forKey:@"cursor"];
    }
    [WBHttpRequest requestWithURL:url httpMethod:@"GET" params:params delegate:self withTag:nil];
}

#pragma mark ---WBHttpRequest delegate
-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSError *error;
    NSDictionary *userDIC=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *userArray=[userDIC objectForKey:@"users"];
    /*
     *[
     ["用户1","用户2","用户3"];  一个cell显示3个
     ["用户1","用户2","用户3"];  再个cell显示3个
     ....
     ];
     *
     */
    NSMutableArray *array2D=nil;
    for (int i=0; i<userArray.count; i++) {
        array2D=[self.data lastObject];
        //每次判断最后一个数组是否填满数据
        if (array2D.count==3||array2D==nil) {
            array2D =[NSMutableArray arrayWithCapacity:3];
            [self.data addObject:array2D];
        }
        NSDictionary *userDic=[userArray objectAtIndex:i];
        User *userModel=[User objectWithKeyValues:userDic];
        [array2D addObject:userModel];
    }
    if (userArray.count<40) {
#warning 判断是否下拉
    }else{
#warning 判断是否下拉
    }
    self.tableView.data=self.data;
    [self.tableView reloadData];
    
    //收起下来
    if (self.cursor==nil) {
#warning 不在加载
//        [self.tableView done]
    }
    
    //记录下一页游标值
    self.cursor=[[userDIC objectForKey:@"next_cursor"]stringValue];
}

#pragma mark - UITableViewEventDelegate
//下拉
-(void)pullDown:(BaseTableView *)tableView{
    self.cursor=nil;
    [self.data removeAllObjects];
    if (self.friendType==Fans) {
        [self loadData:WB_fans];
    }else if (self.friendType==Follows){
        [self loadData:WB_friends];
    }
}
//上拉
-(void)pullUp:(BaseTableView *)tableView{
    if (self.friendType==Fans) {
        [self loadData:WB_fans];
    }else if (self.friendType==Follows){
        [self loadData:WB_friends];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
