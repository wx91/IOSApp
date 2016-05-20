//
//  ListDetailViewController.h
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"
#import "Checklist.h"

@interface ListDetailViewController : UITableViewController<UITextFieldDelegate,IconPickerViewControllerDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIBarButtonItem *doneBarButton;

@property(nonatomic,strong) UILabel *label;

@property(nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic, strong) Checklist *checklistToEdit;

@end
