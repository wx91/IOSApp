//
//  CommentTableView.m
//  CustomWeibo
//
//  Created by wangx on 15/8/11.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
#import "UIViewExt.h"

@implementation CommentTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}

#pragma mark - TableViewDelegate
//tableView顶部不会滑下去的view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *commentCount = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 100, 20)];
    commentCount.backgroundColor = [UIColor clearColor];
    commentCount.font = [UIFont boldSystemFontOfSize:16.0f];
    commentCount.textColor = [UIColor blueColor];
    commentCount.text = [NSString stringWithFormat:@"评论数:%@",_totalCommentNumber];
    [view addSubview:commentCount];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"commentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell=[[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    Comment *commmentModel = [self.data objectAtIndex:indexPath.row];
    cell.commentModel = commmentModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Comment *commmentModel = [self.data objectAtIndex:indexPath.row];
    float h = [CommentCell getCommentHeight:commmentModel];
    return h + 42;
}

//选中评论cell，出现回复转发等选项
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
