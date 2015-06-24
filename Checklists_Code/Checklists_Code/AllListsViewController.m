//
//  UITableViewController.m
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "Checklist.h"
#import "AllListsViewController.h"
#import "ListDetailViewController.h"
@interface AllListsViewController ()

@end

@implementation AllListsViewController

-(void)loadView{
    [super loadView];
    UIBarButtonItem *addBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddChecklist)];
    self.navigationItem.rightBarButtonItem=addBarButtonItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.lists=[[NSMutableArray alloc]initWithCapacity:20];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.lists count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer=@"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifer];
    }
    Checklist *checklist=self.lists[indexPath.row];
    
    cell.textLabel.text=checklist.name;
    
    cell.imageView.image=[UIImage imageNamed:checklist.iconName];
    
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    
    cell.detailTextLabel.text=@"No Items";
    
    return cell;
}

//是否可以删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//删除是触发的方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //删除list中的内容
        [self.lists removeObjectAtIndex:indexPath.row];
        //在tableview中删除该列
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)AddChecklist{
    ListDetailViewController *listDetailVC=[[ListDetailViewController alloc]init];
    listDetailVC.delegate=self;
    [self.navigationController pushViewController:listDetailVC animated:YES];
}
//点击tableviewcell中的小详细按钮进行描述方法中
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    ListDetailViewController *controller = [[ListDetailViewController alloc]init];
    controller.delegate = self;
    Checklist *checklist=self.lists[indexPath.row];
    controller.checklistToEdit=checklist;
    [self.navigationController pushViewController:controller animated:YES];
}

//实现ListDetailViewControllerDelegate中的三个方法
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self.navigationController popToViewController:self animated:YES];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist
{
    [self.lists addObject:checklist];
    [self.tableView reloadData];
    [self.navigationController popToViewController:self animated:YES];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist
{
    [self.tableView reloadData];
    [self.navigationController popToViewController:self animated:YES];
}
@end
