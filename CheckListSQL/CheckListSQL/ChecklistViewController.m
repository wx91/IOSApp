//
//  ChecklistViewController.m
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "Checklist.h"
#import "ChecklistItem.h"
#import "AllListsViewController.h"
#import "ChecklistViewController.h"
#import "ItemDetailViewController.h"
#import "ChecklistItemService.h"
@interface  ChecklistViewController()

@property (nonatomic, strong) NSMutableArray *dataOfChecklistItem;

@property (nonatomic, strong) ChecklistItemService *checklistItemService;

@end

@implementation ChecklistViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.checklist.name;
    //    self.navigationItem.leftItemsSupplementBackButton=YES;
    
    UIBarButtonItem *backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Checklist" style:UIBarButtonItemStyleDone target:self action:@selector(BackAlllists)];
    self.navigationItem.leftBarButtonItem=backBarButtonItem;
    
    
    UIBarButtonItem *addBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddChecklistItem)];
    self.navigationItem.rightBarButtonItem=addBarButtonItem;
    
    self.checklistItemService=[[ChecklistItemService alloc]init];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _dataOfChecklistItem = [_checklistItemService findByChecklist:self.checklist];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataOfChecklistItem count];
}
//配置每一行的cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifer=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 20, 30)];
    label1.tag=101;
    [cell.contentView addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(30, 7, 240, 30)];
    label2.tag=102;
    [cell.contentView addSubview:label2];
    
    ChecklistItem *checklistitem=self.dataOfChecklistItem[indexPath.row];
    [self configureTextForCell:cell withChecklistItem:checklistitem];
    [self configureCheckmarkForCell:cell withChecklistItem:checklistitem];
    
    cell.accessoryType=UITableViewCellAccessoryDetailButton;
    return cell;
}
//设置是否选择
- (void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:101];
    if (item.checked) {
        label.text = @"√";
    } else {
        label.text = @"";
    }
    label.textColor = self.view.tintColor;
}
//配置其中的文字描述
- (void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:102];
    label.text = item.context;
}
//点击后改变它的选择状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ChecklistItem *item = self.dataOfChecklistItem[indexPath.row];
    item.checked = !item.checked;
    [_checklistItemService changeChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)AddChecklistItem{
    ItemDetailViewController *controller=[[ItemDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    controller.delegate=self;
    ChecklistItem *item =  [[ChecklistItem alloc]init];
    item.checklistId = _checklist.checklistId;
    controller.itemToEdit =item;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)BackAlllists{
    [self.delegate ChecklistViewControllerDidBack:self];
}

//点击tableviewcell中的小详细按钮进行描述方法中
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    ItemDetailViewController *controller=[[ItemDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    controller.delegate=self;
    controller.itemToEdit=self.dataOfChecklistItem[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

//是否可以删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//删除是触发的方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //删除list中的内容
        ChecklistItem *item = [_dataOfChecklistItem objectAtIndex:indexPath.row];
        [self.checklistItemService deleteChecklistItem:item];
        
        [self.dataOfChecklistItem removeObjectAtIndex:indexPath.row];
        //在tableview中删除该列
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark ItemDetailViewControllerDelegate
//点击cancel按钮触发的方法
- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller{
    [self.navigationController popToViewController:self animated:YES];
}
//点击增加触发的方法
//- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item{
//    NSInteger newRowIndex=[self.checklist.items count];
//    [self.checklist.items addObject:item];
//    NSIndexPath *indexPath=[NSIndexPath indexPathForItem:newRowIndex inSection:0];
//    NSArray *indexPaths=@[indexPath];
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self.navigationController popToViewController:self animated:YES];
//}
//编辑后返回的方法
//- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item{
//    NSInteger index=[self.checklist.items indexOfObject:item];
//    NSIndexPath *indexPath=[NSIndexPath indexPathForItem:index inSection:0];
//    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
//    [self configureTextForCell:cell withChecklistItem:item];
//    [self.navigationController popToViewController:self animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
