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
//获取屏幕宽度
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
//获取屏幕高度
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ItemDetailViewController()

@property (nonatomic, strong) ChecklistItemService *checklistItemService;

@property(nonatomic,strong)UIBarButtonItem *doneBarButton;

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong) UISwitch *switchControl;

@property(nonatomic,strong) UILabel *dueDateLabel;

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation ItemDetailViewController{
    NSString *_context;
    BOOL _shouldRemind;
    BOOL _datePickerVisible;
    NSDate *_dueDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    UIBarButtonItem *cancelBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem=cancelBarButton;
    
    self.doneBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem=self.doneBarButton;
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, (KScreenHeight-320), KScreenWidth, 320)];
    self.datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.datePicker addTarget:self action:@selector(dateDidChanged:) forControlEvents:UIControlEventValueChanged];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.datePicker.locale = locale;
    self.datePicker.hidden=YES;
    if (self.itemToEdit.dueDate != nil) {
        self.datePicker.date = self.itemToEdit.dueDate;
    }
    [self.view addSubview:self.datePicker];

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
    return 3;
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
        self.textField=[[UITextField alloc]init];
        self.textField.frame =CGRectMake(10, 10, KScreenWidth-20, 30);
        self.textField.placeholder=@"Checklist of Name";
        self.textField.text=_context;
        [cell.contentView addSubview:self.textField];
    }else if (indexPath.row==1){//设置是否进行提醒
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(10, 10, 100, 30);
        label.text=@"Remind Me";
        label.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        self.switchControl=[[UISwitch alloc]init];
        self.switchControl.frame=CGRectMake(KScreenWidth-70, 10, 60, 30);
        self.switchControl.on=_shouldRemind;
        [cell.contentView addSubview:self.switchControl];
    }else if(indexPath.row==2){//设置是否记录日期
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(10, 10, 100, 30);
        label.text=@"Due Date";
        label.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        self.dueDateLabel=[[UILabel alloc]init];
        self.dueDateLabel.frame=CGRectMake(120,10,KScreenWidth-130,30);
        self.dueDateLabel.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:self.dueDateLabel];
        [self updateDueDateLabel];
    }
    return cell;
}
//点击某一行进行处理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.textField resignFirstResponder];
    if (indexPath.section==0&&indexPath.row==2) {
        self.datePicker.hidden=NO;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)done{
    if (self.itemToEdit.context ==nil) {
        self.itemToEdit.checklistItemID = [[NSUUID UUID]UUIDString];
        self.itemToEdit.context=self.textField.text;
        self.itemToEdit.checked=NO;
        self.itemToEdit.shouldRemind=self.switchControl.on;
        self.itemToEdit.dueDate=_dueDate;
        [_checklistItemService addChecklistItem:self.itemToEdit];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        self.itemToEdit.context = self.textField.text;
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = _dueDate;
        [_checklistItemService changeChecklistItem:self.itemToEdit];
        [self.navigationController popViewControllerAnimated:YES];
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
-(void)dateDidChanged:(UIDatePicker*)datePicker{
    _dueDate = datePicker.date;
    [self updateDueDateLabel];
}


@end
