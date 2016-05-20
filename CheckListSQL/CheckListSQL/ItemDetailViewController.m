//
//  ItemDetailViewController.m
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"
#import "ChecklistItemService.h"

@interface ItemDetailViewController()

@property (nonatomic, strong) ChecklistItemService *checklistItemService;

@end

@implementation ItemDetailViewController{
    NSString *_context;
    BOOL _shouldRemind;
    BOOL _datePickerVisible;
    NSDate *_dueDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *cancelBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem=cancelBarButton;
    
    self.doneBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem=self.doneBarButton;
    
    self.checklistItemService=[[ChecklistItemService alloc]init];
    
    if (self.itemToEdit.context != nil) {
        self.title=@"Edit Item";
        _context=self.itemToEdit.context;
        _shouldRemind=self.itemToEdit.shouldRemind;
        _dueDate=self.itemToEdit.dueDate;
    }else{
        self.title=@"Add Item";
        self.switchControl.on=NO;
        _dueDate=[NSDate date];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //称为第一响应者
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//返回每一个section中的row数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section ==0 && _datePickerVisible){
        return 4;
    }else{
        return 3;
    }
}
//新建UITableViewCell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifer=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    //填写待办事项的名字
    if(indexPath.row==0){
        self.textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 7, 300, 30)];
        self.textField.placeholder=@"Checklist of Name";
        self.textField.text=_context;
        [cell.contentView addSubview:self.textField];
    }else if (indexPath.row==1){//设置是否进行提醒
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(10, 7, 100, 30);
        label.text=@"Remind Me";
        label.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        self.switchControl=[[UISwitch alloc]init];
        self.switchControl.frame=CGRectMake(250, 6, 51, 31);
        self.switchControl.on=_shouldRemind;
        [cell.contentView addSubview:self.switchControl];
        
    }else if(indexPath.row==2){//设置是否记录日期
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(10, 7, 80, 30);
        label.text=@"Due Date";
        label.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        self.dueDateLabel=[[UILabel alloc]init];
        self.dueDateLabel.frame=CGRectMake(100, 7, 220, 30);
        self.dueDateLabel.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:self.dueDateLabel];
        [self updateDueDateLabel];
    }else{
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIDatePicker *datePicker=[[UIDatePicker alloc]init];
        datePicker.frame=CGRectMake(0,0,320,300);
        datePicker.tag=100;
        [cell.contentView addSubview:datePicker];
        
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return cell;
}
//将要选中时进行处理
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置只有 due Date 哪一行可以点击
    if(indexPath.section==0&&indexPath.row==2){
        return indexPath;
    }else{
        return nil;
    }
}
//点击某一行进行处理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.textField resignFirstResponder];
    if (indexPath.section==0&&indexPath.row==2) {
        if (!_datePickerVisible) {
            [self showDatePick];
        }else{
            [self hideDatePicker];
        }
    }
}

-(void)cancel{
    [self.delegate itemDetailViewControllerDidCancel:self];
}
-(void)done{
    if (self.itemToEdit.context ==nil) {
//        ChecklistItem *item=[[ChecklistItem alloc]init];
        self.itemToEdit.context=self.textField.text;
        self.itemToEdit.checked=NO;
        self.itemToEdit.shouldRemind=self.switchControl.on;
        self.itemToEdit.dueDate=_dueDate;
//        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
        [_checklistItemService addChecklistItem:self.itemToEdit];
        [self.delegate itemDetailViewControllerDidCancel:self];
    }else{
        self.itemToEdit.context = self.textField.text;
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = _dueDate;
//        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
        [_checklistItemService changeChecklistItem:self.itemToEdit];
        [self.delegate itemDetailViewControllerDidCancel:self];
    }
}

//显示选择的日期内容
-(void)updateDueDateLabel{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text=[formatter stringFromDate:_dueDate];
}
//获取到选中的日期，并填写到表格中去
-(void)dateChanged:(UIDatePicker*)datePicker{
    _dueDate = datePicker.date;
    [self updateDueDateLabel];
}

//显示日期并进行选择
-(void)showDatePick{
    _datePickerVisible=YES;
    //日期选择一行
    NSIndexPath *indexPathDateRow=[NSIndexPath indexPathForRow:2 inSection:0];
    //新建一行展示日期选项
    NSIndexPath *indexPathDatePicker=[NSIndexPath indexPathForRow:3 inSection:0];
//    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPathDateRow];
    self.dueDateLabel.tintColor=[UIColor blueColor];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPathDatePicker]  withRowAnimation:YES];
    [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
    UITableViewCell *datePickerCell=[self.tableView cellForRowAtIndexPath:indexPathDatePicker];
    UIDatePicker *datePicker=(UIDatePicker *)[datePickerCell viewWithTag:100];
    [datePicker setDate:_dueDate animated:YES];
}
-(void)hideDatePicker{
    if (_datePickerVisible) {
        _datePickerVisible=NO;
        //日期选择一行
        NSIndexPath *indexPathDateRow=[NSIndexPath indexPathForRow:2 inSection:0];
        //新建一行展示日期选项
        NSIndexPath *indexPathDatePicker=[NSIndexPath indexPathForRow:3 inSection:0];
        //    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPathDateRow];
        self.dueDateLabel.textColor=[UIColor colorWithWhite:0.0f alpha:0.5f];
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView deleteRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
