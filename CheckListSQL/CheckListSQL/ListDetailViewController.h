//
//  ListDetailViewController.h
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class ListDetailViewController;
@class Checklist;

@protocol ListDetailViewControllerDelegate <NSObject>
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
//
//- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist;
//- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist;
@end


@interface ListDetailViewController : UITableViewController<UITextFieldDelegate,IconPickerViewControllerDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIBarButtonItem *doneBarButton;

@property(nonatomic,strong) UILabel *label;

@property(nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic, strong) Checklist *checklistToEdit;

@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;

@end
