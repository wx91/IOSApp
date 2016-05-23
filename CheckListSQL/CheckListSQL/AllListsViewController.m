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
#import "ChecklistViewController.h"
#import "ChecklistService.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface AllListsViewController()

@property (nonatomic, assign)NSInteger  pageNo;

@property (nonatomic, strong) NSMutableArray *dataOfChecklist;

@property (nonatomic, strong) ChecklistService *checklistService;



@end

@implementation AllListsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    self.pageNo =1;
    self.dataOfChecklist = [NSMutableArray array];
    //初始化服务
    _checklistService = [[ChecklistService alloc]init];
    
    self.title=@"Checklist";
    UIBarButtonItem *addBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddChecklist)];
    self.navigationItem.rightBarButtonItem=addBarButtonItem;
    //下拉刷新
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshChecklist];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreChecklist];
    }];
    self.tableView.mj_footer.automaticallyHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataOfChecklist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer=@"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifer];
    }
    Checklist *checklist=self.dataOfChecklist[indexPath.row];
    cell.textLabel.text=checklist.name;
    cell.imageView.image=[UIImage imageNamed:checklist.iconName];
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    
    int count=[_checklistService countUncheckedItems:checklist];
    if(count ==0){
        cell.detailTextLabel.text =@"全部搞定收工！";
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaining",count];
    }
    cell.imageView.image=[UIImage imageNamed:checklist.iconName];
    return cell;
}

//点击加号进入
-(void)AddChecklist{
    ListDetailViewController *listDetailVC=[[ListDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:listDetailVC animated:YES];
}
//点击tableviewcell中的小详细按钮进行描述方法中
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    ListDetailViewController *controller = [[ListDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    Checklist *checklist=self.dataOfChecklist[indexPath.row];
    controller.checklistToEdit=checklist;
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
        Checklist *checklist = [_dataOfChecklist objectAtIndex:indexPath.row];
        [self.checklistService deleteChecklist:checklist];
        [self.dataOfChecklist removeObjectAtIndex:indexPath.row];
        //在tableview中删除该列
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChecklistViewController *controller=[[ChecklistViewController alloc]init];
    Checklist *checklist=self.dataOfChecklist[indexPath.row];
    controller.checklist=checklist;
    controller.delegate=self;
    [self.navigationController pushViewController:controller animated:YES];
}

//实现ListDetailViewControllerDelegate中的三个方法
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self.navigationController popToViewController:self animated:YES];
}

-(void)ChecklistViewControllerDidBack:(ChecklistViewController *)controller{
    [self.tableView reloadData];
    [self.navigationController popToViewController:self animated:YES];
}


#pragma mark 加载
-(void)refreshChecklist{
    [self requestMoreChecklist:YES];
}

-(void)loadMoreChecklist{
    [self requestMoreChecklist:NO];
}

-(void)requestMoreChecklist:(BOOL)isRefresh{
    if (isRefresh) {
        self.pageNo =  1;
        [self.tableView.mj_header endRefreshing];
        [self.dataOfChecklist removeAllObjects];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
    NSMutableArray *checklists = [_checklistService findAllByPage:self.pageNo withPageRow:2];
    if(isRefresh){
        self.pageNo = 2;
    }else{
        self.pageNo ++;
    }
    [self.dataOfChecklist addObjectsFromArray:checklists];
    if (checklists.count > 0) {
        [self.tableView.mj_footer resetNoMoreData];
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [SVProgressHUD showInfoWithStatus:@"没有更多数据了!"];
    }
    
    [self.tableView reloadData];
}
@end
