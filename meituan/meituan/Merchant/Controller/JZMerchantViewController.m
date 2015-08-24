//
//  JZMerchantViewController.m
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "JZMerchantViewController.h"

#import "Constant.h"
#import "NetworkSingleton.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "JZMerchantModel.h"
#import "AppDelegate.h"
#import "JZMerchantCell.h"
#import "JZMerchantDetailViewController.h"

@implementation JZMerchantViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self initData];
    
}
#pragma mark 初始化数据
-(void)initData{
    _MerchantArray =[[NSMutableArray alloc]init];
    NSUserDefaults *userD=[NSUserDefaults standardUserDefaults];
    _locationInfoStr=[userD objectForKey:@"location"];
    _offset=0;
    _KindID=-1;//默认为-1
}
#pragma mark 初始化自定义导航栏
-(void)setNav{
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:backView];
    //下划线
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 63.5, screen_width, 0.5)];
    lineView.backgroundColor=RGB(192, 192, 192);
    [backView addSubview:lineView];
    
    //地图按钮
    UIButton *mapButton=[UIButton buttonWithType:UIButtonTypeCustom];
    mapButton.frame=CGRectMake(10, 30, 23, 23);
    [mapButton setImage:[UIImage imageNamed:@"icon_map"] forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(OnBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:mapButton];
    //搜索按钮
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(screen_width-42, 30, 23, 23);
    [searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(OnSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:searchBtn];
    //segment
    UIButton *segBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    segBtn1.frame=CGRectMake(screen_width/2-80, 30, 80, 30);
    segBtn1.tag=20;
    [segBtn1 setTitle:@"全部商家" forState:UIControlStateNormal];
    [segBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [segBtn1 setTitleColor:navigationBarColor forState:UIControlStateNormal];
    [segBtn1 setBackgroundColor:navigationBarColor];
    segBtn1.selected=YES;
    segBtn1.titleLabel.font=[UIFont systemFontOfSize:15];
    segBtn1.layer.borderWidth=1;
    segBtn1.layer.borderColor=[navigationBarColor CGColor];
    [segBtn1 addTarget:self action:@selector(OnSegBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:segBtn1];
    
    UIButton *segBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    segBtn2.frame=CGRectMake(screen_width/2, 30, 80, 30);
    segBtn2.tag=21;
    [segBtn2 setTitle:@"优惠商家" forState:UIControlStateNormal];
    [segBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [segBtn2 setTitleColor:navigationBarColor forState:UIControlStateNormal];
    [segBtn2 setBackgroundColor:[UIColor whiteColor]];
    segBtn2.titleLabel.font=[UIFont systemFontOfSize:15];
    segBtn2.layer.borderWidth = 1;
    segBtn2.layer.borderColor = [navigationBarColor CGColor];
    [segBtn2 addTarget:self action:@selector(OnSegBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:segBtn2];
}

#pragma mark 自定义下拉选择
-(void)initViews{
    UIView *filterView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, screen_width, 40)];
    filterView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:filterView];
    
    NSArray *filterName=@[@"全部",@"全部",@"智能排序"];
    //筛选
    for (int i=0; i<3; i++) {
        //文字
        UIButton *filterBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        filterBtn.frame=CGRectMake(i*screen_width/3, 0, screen_width/3-15, 40);
        filterBtn.tag=100+i;
        filterBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [filterBtn setTitle:filterName[i] forState:UIControlStateNormal];
        [filterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [filterBtn setTitleColor:navigationBarColor forState:UIControlStateSelected];
        [filterBtn addTarget:self action:@selector(OnFilterBtn:) forControlEvents:UIControlEventTouchUpInside];
        [filterView addSubview:filterBtn];
        //三角形
        UIButton *sanjiaoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sanjiaoBtn.frame=CGRectMake((i+1)*screen_width/3-15, 16, 8, 7);
        sanjiaoBtn.tag=120+i;
        [sanjiaoBtn setImage:[UIImage imageNamed:@"icon_arrow_dropdown_normal"] forState:UIControlStateNormal];
        [sanjiaoBtn setImage:[UIImage imageNamed:@"icon_arrow_dropdown_selected"] forState:UIControlStateSelected];
        [filterBtn addSubview:sanjiaoBtn];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, screen_width, 0.5)];
    lineView.backgroundColor = RGB(192, 192, 192);
    [filterView addSubview:lineView];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+40, screen_width, screen_height-64-40-49) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self setUpTableView];
    
    
}
#pragma mark 设置tableview的下拉等
-(void)setUpTableView{
    //添加下拉的动画图片
    //设置下拉刷新回调
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(getFirstPageData)];
    //设置普通状态下的动画图片
    NSMutableArray *idleImages=[NSMutableArray array];
    for (NSUInteger i=1; i<=60; ++i) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    //设置即将刷新状态的动画图片
    NSMutableArray *refreshingImages=[NSMutableArray array];
    for (NSInteger i=1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    //设置正在刷新是的动画图片
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    //马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
    //上拉刷新
    [self.tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //设置正在刷新的动画
    self.tableView.gifFooter.refreshingImages = refreshingImages;
}

#pragma mark 遮罩页
-(void)initMaskView{
    _maskView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+40, screen_width, screen_height-64-40-49)];
    _maskView.backgroundColor=RGBA(0, 0, 0, 0.5);
    [self.view addSubview:_maskView];
    _maskView.hidden=YES;
    
    //添加手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapMaskView:)];
    tap.delegate=self;
    [_maskView addGestureRecognizer:tap];
    
    _groupView=[[JZMerchantFilterView alloc]initWithFrame:CGRectMake(0, 0, screen_width, _maskView.frame.size.height-90)];
    _groupView.delegate=self;
    [_maskView addSubview:_groupView];
}
#pragma  mark -响应事件
-(void)OnBackBtn:(UIButton *)sender{
    NSLog(@"地图");
}

-(void)OnSearchBtn:(UIButton *)sender{
    NSLog(@"搜索");
}
-(void)OnSegBtn:(UIButton *)sender{
    NSInteger tag = sender.tag;
    UIButton *segBtn1 = (UIButton *)[self.view viewWithTag:20];
    UIButton *segBtn2 = (UIButton *)[self.view viewWithTag:21];
    [segBtn1 setBackgroundColor:[UIColor whiteColor]];
    [segBtn2 setBackgroundColor:[UIColor whiteColor]];
    segBtn1.selected = NO;
    segBtn2.selected = NO;
    sender.selected = YES;
    [sender setBackgroundColor:navigationBarColor];
    if (tag == 20) {
        NSLog(@"20");
    }else{
        NSLog(@"21");
    }
}
-(void)OnFilterBtn:(UIButton *)sender{
    for (int i=0; i<3; i++) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:100+i];
        UIButton *sanjiaoBtn=(UIButton *)[self.view viewWithTag:120+i];
        btn.selected=NO;
        sanjiaoBtn.selected=NO;
    }
    sender.selected=YES;
    UIButton *sjBtn=(UIButton *)[self.view viewWithTag:sender.tag+20];
    sjBtn.selected=YES;
    _maskView.hidden=NO;
}

-(void)OnTapMaskView:(UITapGestureRecognizer *)sender{
    _maskView.hidden = YES;
}
#pragma mark - 请求数据

//获取当前位置信息
-(void)OnRefreshLocationBtn:(UIButton *)sender{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getPresentLocation];
    });
}
-(void)getFirstPageData{
    _offset = 0;
    [self refreshData];
}

-(void)refreshData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getMerchantList];
    });
}

-(void)loadMoreData{
    NSLog(@"2222  offset:%zd",_offset);
    _offset = _offset + 20;
    NSLog(@"3333  offset:%zd",_offset);
    [self refreshData];
}
#pragma mark 获取商家列表
-(void)getMerchantList{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *str=@"%2C";
    NSString *hostStr = @"http://api.meituan.com/group/v1/poi/select/cate/";
    NSString *paramsStr = @"?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=WOdaAXJTFxIjDdjmt1z%2FJRzB6Y0%3D&__skno=91D0095F-156B-4392-902A-A20975EB9696&__skts=1436408836.151516&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&areaId=-1&ci=1&cityId=1&client=iphone&coupon=all&limit=20&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-09-09-42570&mypos=";
    NSString *str1=[NSString stringWithFormat:@"%@%ld%@",hostStr,(long)_KindID,paramsStr];
    NSString *str2 = @"&sort=smart&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_i550poi_xxyl__b__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    NSString *urlStr = [NSString stringWithFormat:@"%@%f%@%f&offset=%zd%@",str1, delegate.latitude, str, delegate.longitude, _offset,str2];
    [[NetworkSingleton shareManager]getMerchantListResult:nil url:urlStr successBlock:^(id responseBody) {
        NSLog(@"获取商家列表成功");
        NSMutableArray *dataArray=[responseBody objectForKey:@"data"];
        NSLog(@"%ld",dataArray.count);
        NSLog(@"offset:%ld",_offset);
        if (_offset==0) {
            NSLog(@"0000");
            [_MerchantArray removeAllObjects];
        }
        for (int i=0; i<dataArray.count; i++) {
            JZMerchantModel *JZMerM=[JZMerchantModel objectWithKeyValues:dataArray[i]];
            [_MerchantArray addObject:JZMerM];
        }
        [self.tableView  reloadData];
        if (_offset==0&&dataArray.count!=0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];

    } failureBlock:^(NSString *error) {
        NSLog(@"获取商家列表失败：%@",error);
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
    
}

//获取当前位置
-(void)getPresentLocation{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *urlStr = @"http://api.meituan.com/group/v1/city/latlng/39.982207,116.311906?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=dhdVkMoRTQge4RJQFlm2iIF2e5s%3D&__skno=9B646232-F7BF-4642-B9B0-9A6ED68003D2&__skts=1436408843.060582&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-09-09-42570&tag=1&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_i550poi_xxyl__b__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    _locationInfoStr = @"正在定位...";
    [self.tableView reloadData];
    [[NetworkSingleton shareManager]getPresentLocationResult:nil url:urlStr successBlock:^(id responseBody) {
        NSLog(@"获取当前位置信息成功");
        NSDictionary *dataDic = [responseBody objectForKey:@"data"];
        _locationInfoStr = [dataDic objectForKey:@"detail"];
        
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        [userD setObject:_locationInfoStr forKey:@"location"];
        
        [self.tableView reloadData];
    } failureBlock:^(NSString *error) {
        NSLog(@"获取当前位置信息失败:%@",error);
    }];
}

//获取cate分组信息
-(void)getCateListData{
    NSString *urlStr = @"http://api.meituan.com/group/v1/poi/cates/showlist?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=hSjSxtGbfd1QtKRMWnoFV4GB8jU%3D&__skno=0DEF926E-FB94-43B8-819E-DD510241BCC3&__skts=1436504818.875030&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&cityId=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-10-12-44726&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    
    [[NetworkSingleton shareManager] getCateListResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"获取cate分组信息成功");
    } failureBlock:^(NSString *error){
        NSLog(@"获取cate分组信息失败:%@",error);
    }];
}

#pragma mark UITableViewDataSource
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MerchantArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 30)];
    headerView.backgroundColor = RGB(240, 239, 237);
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screen_width-10-40, 30)];
    locationLabel.font = [UIFont systemFontOfSize:13];
    locationLabel.text = [NSString stringWithFormat:@"当前位置：%@",_locationInfoStr];
    locationLabel.textColor = [UIColor lightGrayColor];
    [headerView addSubview:locationLabel];
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(screen_width-30, 5, 20, 20);
    [refreshBtn setImage:[UIImage imageNamed:@"icon_dellist_locate_refresh"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(OnRefreshLocationBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:refreshBtn];
    return headerView;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"merchantCell";
    JZMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[JZMerchantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    JZMerchantModel *jzMerM = _MerchantArray[indexPath.row];
    cell.jzMerM = jzMerM;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JZMerchantModel *jzMerM = _MerchantArray[indexPath.row];
    NSLog(@"poiid:%@",jzMerM.poiid);
    
    JZMerchantDetailViewController *jzMerchantDVC = [[JZMerchantDetailViewController alloc] init];
    jzMerchantDVC.poiid = jzMerM.poiid;
    [self.navigationController pushViewController:jzMerchantDVC animated:YES];
    
}
#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return NO;
    }
    if ([touch.view.superview isKindOfClass:[UITableView class]]) {
        return NO;
    }
    if ([touch.view.superview.superview isKindOfClass:[UITableView class]]) {
        return NO;
    }
    if ([touch.view.superview.superview.superview isKindOfClass:[UITableView class]]) {
        return NO;
    }
    return YES;
    
}


@end
