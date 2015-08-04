//
//  CommentTableView.m
//  WXWeibo
//
//  Created by wangx on 15/8/4.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
#import "CommentModel.h"
#import "UIViewExt.h"

@implementation CommentTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

#pragma mark UITableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"CommentCell";
    CommentCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil]lastObject];
    }
    CommentModel *commentModel=[self.data objectAtIndex:indexPath.row];
    cell.commentModel=commentModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *commentModel=[self.data objectAtIndex:indexPath.row];
    float h=[CommentCell getCommentHeight:commentModel];
    return h+40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    view.backgroundColor=[UIColor whiteColor];
    
    UILabel *commentCount=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    commentCount.backgroundColor=[UIColor clearColor];
    commentCount.font=[UIFont boldSystemFontOfSize:16.0f];
    commentCount.textColor=[UIColor blueColor];
    [view addSubview:commentCount];
    NSNumber *total=[self.commentDic objectForKey:@"total_number"];
    commentCount.text=[NSString stringWithFormat:@"评论%@",total];
    
    UIImageView *separeView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 39, tableView.width, 1)];
    separeView.image=[UIImage imageNamed:@"userinfo_header_separator.png"];
    
    [view addSubview:separeView];
    
    return view;
}

@end
