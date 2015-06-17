//
//  CategoryPickViewController.m
//  MyLocation
//
//  Created by wangx on 15/5/3.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "CategoryPickViewController.h"

@implementation CategoryPickViewController{
    NSArray *_categories;
    NSIndexPath *_selectedIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _categories=@[@"No Category",@"Apple Store",@"Bar",@"BookStore",@"Club",@"Grocery Store",@"Historic Building",@"House",@"Icecream Vendor",@"LandMark",@"Park"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSString *categoryName=_categories[indexPath.row];
    cell.textLabel.text=categoryName;
    if ([categoryName isEqualToString:self.selectedCategoryName]) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row!=_selectedIndexPath.row) {
        UITableViewCell *newCell=[tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType=UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldcell=[tableView cellForRowAtIndexPath:_selectedIndexPath];
        oldcell.accessoryType=UITableViewCellAccessoryNone;
        _selectedIndexPath=indexPath;
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"PickedCategory"]) {
        UITableViewCell *cell=sender;
        NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
        self.selectedCategoryName=_categories[indexPath.row];
    }
}


@end
