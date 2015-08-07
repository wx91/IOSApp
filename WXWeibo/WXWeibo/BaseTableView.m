//
//  BaseTableView.m
//  WXWeibo
//
//  Created by wangx on 15/8/1.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseTableView.h"
#import "Constant.h"
#import "UIViewExt.h"

@implementation BaseTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}
//从nib中初始化
-(void)awakeFromNib{
    [self initView];
}

-(void)initView{
    _refreshHeaderView =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    _refreshHeaderView.backgroundColor=[UIColor clearColor];
    self.dataSource=self;
    self.delegate=self;
    self.refreshHeader=YES;
    
    _moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.backgroundColor=[UIColor clearColor];
    _moreButton.frame=CGRectMake(0, 0, ScreenWidth, 40);
    _moreButton.titleLabel.font=[UIFont systemFontOfSize:16.0f];
    [_moreButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoreAction) forControlEvents:UIControlEventTouchUpInside];
     UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.tag=2013;
    activityView.frame=CGRectMake(100, 10, 20, 20);
    [activityView stopAnimating];
    [_moreButton addSubview:activityView];
    
    self.tableFooterView=_moreButton;
}

-(void)startLoadMore{
    [_moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    _moreButton.enabled=NO;
    UIActivityIndicatorView *activityView=(UIActivityIndicatorView *)[_moreButton viewWithTag:2013];
    [activityView startAnimating];
    
}

-(void)stopLoadMore{
    if(self.data.count>0){
        _moreButton.hidden=NO;
        [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
        _moreButton.enabled=YES;
        UIActivityIndicatorView *activityView=(UIActivityIndicatorView *)[_moreButton viewWithTag:2013];
        [activityView stopAnimating];
        if (!self.isMore) {
            [_moreButton setTitle:@"全部加载完成" forState:UIControlStateNormal];
            _moreButton.enabled=NO;
        }
    }else{
        _moreButton.hidden=YES;
    }
    
}

-(void)loadMoreAction{
    if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
        [self.eventDelegate pullUp:self];
        [self startLoadMore];
    }
}


-(void)setRefreshHeader:(BOOL)refreshHeader{
    _refreshHeader=refreshHeader;
    if (_refreshHeader) {
        [self addSubview:_refreshHeaderView];
    }else{
        if ([_refreshHeaderView superview]) {
            [_refreshHeaderView removeFromSuperview];
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

-(void)refreshData{
    
//    [_refreshHeaderView refreshLoding:self];
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)reloadData{
    [super reloadData];
    //停止加载更多
    [self stopLoadMore];
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    _reloading = YES;
}
//停止加载，弹回下拉
- (void)doneLoadingTableViewData{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
//当滑动时，实时调用此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}
//手指停止拖拽的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    if (!self.isMore) {
        return ;
    }
    
    float offset=scrollView.contentOffset.y;
    float contentHeight=scrollView.contentSize.height;
    NSLog(@"偏移量y%f",offset);
    NSLog(@"content高度%f",contentHeight);
    //当offset偏移量滑到底部时，差值是scrollview的高度
    float sub=contentHeight-offset;
    if (sub-scrollView.height>30) {
        [self startLoadMore];
        if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
            [self.eventDelegate pullUp:self];
        }
    }
    
}

#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    //设置为“正在加载”状态
    [self reloadTableViewDataSource];
    //停止加载，弹回下拉
    if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventDelegate pullDown:self];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading;
    
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}

@end
