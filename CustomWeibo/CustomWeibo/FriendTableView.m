//
//  FriendTableView.m
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "FriendTableView.h"
#import "FriendTableViewCell.h"


@implementation FriendTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    FriendTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[FriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSArray *array=[self.data objectAtIndex:indexPath.row];
    cell.data=array;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}



@end
