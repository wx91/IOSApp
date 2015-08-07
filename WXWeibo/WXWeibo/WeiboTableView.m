//
//  WeiboTableView.m
//  WXWeibo
//
//  Created by wangx on 15/8/1.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import "UIViewExt.h"
#import "Constant.h"
@implementation WeiboTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:kReloadWeiboTableNotification object:nil];
    }
    return self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"Weibo Cell";
    WeiboCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    WeiboModel *weibo=[self.data objectAtIndex:indexPath.row];
    if (cell==nil) {
        cell=[[WeiboCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
    }
    cell.weibo=weibo;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboModel *weibo=[self.data objectAtIndex:indexPath.row];
    float height=[WeiboView getWeiboViewHeight:weibo isRepost:NO isDetail:NO];
    height+=80;
    return height;
}



@end
