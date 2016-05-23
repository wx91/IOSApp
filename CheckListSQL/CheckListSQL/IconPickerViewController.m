//
//  IconPickerViewControllerTableViewController.m
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "IconPickerViewController.h"

@implementation IconPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Chonse Icon";
    self.icons=@[
            @"No Icon",
            @"Appointments",
            @"Birthdays",
            @"Chores",
            @"Drinks",
            @"Folder",
            @"Groceries",
            @"Inbox",
            @"Photos",
            @"Trips"
            ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.icons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *icon=self.icons[indexPath.row];
    cell.textLabel.text=icon;
    
    cell.imageView.image=[UIImage imageNamed:icon];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *iconName=self.icons[indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}

@end
