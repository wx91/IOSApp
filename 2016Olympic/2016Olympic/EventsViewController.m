//
//  EventsViewController.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsDetailViewController.h"

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"项目";
    if (self.events == nil || [self.events count] == 0) {
        EventsBL* bl = [[EventsBL alloc] init];
        //获取全部数据
        NSMutableArray *array = [bl readData];
        self.events = array;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.events count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"Cell";
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    Events *event=self.events[indexPath.row];
    NSString *name=event.EventName;
    cell.textLabel.text=name;
    NSString *iconName=event.EventIcon;
    cell.imageView.image=[UIImage imageNamed:iconName];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EventsDetailViewController *detailVC=[[EventsDetailViewController alloc]init];
    Events *event=self.events[indexPath.row];
    detailVC.event=event;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
