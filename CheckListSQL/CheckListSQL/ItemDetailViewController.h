//
//  ItemDetailViewController.h
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;

//- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;

//- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;

@end


@interface ItemDetailViewController : UITableViewController

@property(nonatomic,strong)UIBarButtonItem *doneBarButton;

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong) UISwitch *switchControl;

@property(nonatomic,strong) UILabel *dueDateLabel;

@property (nonatomic, strong) ChecklistItem *itemToEdit;

@property (nonatomic, weak) id <ItemDetailViewControllerDelegate> delegate;


@end
