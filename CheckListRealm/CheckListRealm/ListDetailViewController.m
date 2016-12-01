//
//  ListDetailViewController.m
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "ListDetailViewController.h"
#import "IconPickerViewController.h"
#import "Checklist.h"
#import "ChecklistService.h"

@interface  ListDetailViewController()

@property (nonatomic, strong) ChecklistService *checklistService;

@end


@implementation ListDetailViewController{
    NSString *_name;
    NSString *_iconName;
}

-(void)loadView{
    [super loadView];
    UIBarButtonItem *cancelBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem=cancelBarButtonItem;
    
    self.doneBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem=self.doneBarButton;
    
    _checklistService =[[ChecklistService alloc]init];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.checklistToEdit!=nil) {
        self.title=@"Edit CheckList";
        _name=self.checklistToEdit.name;
        _iconName=self.checklistToEdit.iconName;
    }else{
        self.title=@"Add CheckList";
        _iconName = @"Folder";
    }
    self.iconImageView.image=[UIImage imageNamed:_iconName];
    self.textField.delegate=self;
    [self.textField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row==0) {
        self.textField=[[UITextField alloc]initWithFrame:CGRectMake(30, 7, 300, 30)];
        self.textField.placeholder=@"Name of List";
        self.textField.text=_name;
        [cell.contentView addSubview:self.textField];
    }else{
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(30, 11, 150, 20)];
        self.label.text=_iconName;
        [cell.contentView addSubview:self.label];
        
        self.iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(180, 4, 36, 36)];
        self.iconImageView.image=[UIImage imageNamed:_iconName];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:self.iconImageView];
    }
    return cell;
}
//点击取消按钮时，触发事件
-(void)cancel{
    //回弹到上一个页面
    [self.navigationController popViewControllerAnimated:YES];
}
//点击done按钮时，触发事件
-(void)done{
    //如果传过来的checklistToEdit==nil 则增加，否则修改
    if (self.checklistToEdit==nil) {
        Checklist *checklist=[[Checklist alloc]init];
        checklist.checklistId = [[NSUUID UUID]UUIDString];
        checklist.name=[NSString stringWithString:self.textField.text];
        checklist.iconName=_iconName;
        [_checklistService addChecklist:checklist];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        self.checklistToEdit.name=self.textField.text;
        self.checklistToEdit.iconName=_iconName;
        [_checklistService changeChecklist:self.checklistToEdit];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==3) {
        return 220.0f;
    }else{
        CGFloat height=[super tableView:tableView heightForRowAtIndexPath:indexPath];
        return height;
    }
}
#pragma mark 点击第二行的时候进入选择icon的功能
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        IconPickerViewController *controller=[[IconPickerViewController alloc]initWithStyle:UITableViewStyleGrouped];
        controller.delegate=self;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

#pragma mark IconPickerViewControllerDelegate
-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName{
    _iconName=iconName;
    self.iconImageView.image=[UIImage imageNamed:_iconName];
    self.label.text=_iconName;
    [self.navigationController popToViewController:self animated:YES];
}


@end
