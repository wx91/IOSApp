//
//  BaseTableView.m
//  KittenYang
//
//  Created by Kitten Yang on 14-8-4.
//  Copyright (c) 2014年 Kitten Yang. All rights reserved.
//

#import "BaseTableView.h"
#import "MJRefresh.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}
//使用xib创建
- (void)awakeFromNib{
    [self initView];
}


- (void)initView{
    self.dataSource=self;
    self.delegate=self;
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self pullDownData];
//    }];
//    //// 马上进入刷新状态
//    [self.header beginRefreshing];
//    
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self pullUpData];
//    }];
}



#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.eventDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}

//下来加载数据
-(void)pullDownData{
    if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventDelegate pullDown:self];
    }
}

//上拉显示数据
-(void)pullUpData{
    if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
        [self.eventDelegate pullUp:self];
    }
}
@end
