//
//  ItemDetailViewController.m
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"
@interface ItemDetailViewController (){
    NSString *_text;
}

@end

@implementation ItemDetailViewController

-(void)loadView{
    [super loadView];
    UIBarButtonItem *cancelBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem=cancelBarButton;
    
    self.doneBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem=self.doneBarButton;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.itemToEdit!=nil) {
        self.title=@"Edit Item";
        _text=self.itemToEdit.text;
    }else{
        self.title=@"Add Item";
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(void)cancel{
    [self.delegate itemDetailViewControllerDidCancel:self];
}
-(void)done{
    if (self.itemToEdit==nil) {
        ChecklistItem *item=[[ChecklistItem alloc]init];
        item.text=self.textField.text;
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }else{
        self.itemToEdit.text=self.textField.text;
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifer=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 7, 300, 30)];
    self.textField.placeholder=@"Checklist of Name";
    self.textField.text=_text;
    
    
    [cell.contentView addSubview:self.textField];
    
    return cell;
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
