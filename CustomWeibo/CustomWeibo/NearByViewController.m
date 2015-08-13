//
//  NearByViewController.m
//  CustomWeibo
//
//  Created by wangx on 15/8/13.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "NearByViewController.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我在这里";
    [self initView];
    [super showHUD:@"卖力加载中..." isDim:NO];
    if (nil==self.locationManager) {
        self.locationManager=[[CLLocationManager alloc]init];
    }
    self.locationManager.delegate=self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}
-(void)initView{
    headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, -80, ScreenWidth, 80)];
    headerLabel.backgroundColor=[UIColor clearColor];
    headerLabel.text=@"继续下拉关闭";
    headerLabel.font=[UIFont systemFontOfSize:16.0f];
    headerLabel.textColor=[UIColor blackColor];
    headerLabel.textAlignment=NSTextAlignmentCenter;
    [self.tableView addSubview:headerLabel];
    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    footerView.backgroundColor=[UIColor clearColor];
    self.tableView.tableFooterView=footerView;
}

#pragma mark ClLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation=[locations lastObject];
    NSLog(@"开始定位:%@",newLocation);
    //结束定位
    [manager stopUpdatingLocation];
    if (self.data==nil) {
        CLLocationDegrees longitude=newLocation.coordinate.longitude;
        CLLocationDegrees latitude=newLocation.coordinate.latitude;
        
        NSString *longitudeString=[NSString stringWithFormat:@"%f",longitude];
        NSString *latitudeString=[NSString stringWithFormat:@"%f",latitude];
        
        NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:longitudeString,@"long",latitudeString,@"lat",nil];
        [WBHttpRequest requestWithURL:WB_nearBy httpMethod:@"POST" params:params delegate:self withTag:@"nearBy"];
    }
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"定位错误");
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identity = @"cell";
    UITableViewCell *cell =[ tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }
    NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"title"];
    NSString *subTitle= [dic objectForKey:@"address"];
    NSString *icon = [dic objectForKey:@"icon"];
    
    if (![title isKindOfClass:[NSNull class]]) {
        cell.textLabel.text = title;
    }
    
    if (![subTitle isKindOfClass:[NSNull class]]) {
        cell.detailTextLabel.text = subTitle;
    }
    if (![icon isKindOfClass:[NSNull class]]) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"page_image_loading.png"]];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectBlock != nil) {
        NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
        _selectBlock(dic);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offset = self.tableView.contentOffset.y;
    if (offset < -160) {
        headerLabel.text = @"可以松手了";
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float offset = self.tableView.contentOffset.y;
    if (offset < -160) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        headerLabel.text = @"继续下拉关闭";
    }
}

#pragma mark - WBHttpRequestDelegate
//获得请求数据
-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSError *error;
    NSDictionary *JSONDIC=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *pois=[JSONDIC objectForKey:@"pois"];
    self.data=pois;
    [self.hud hide:YES];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
