//
//  ChecklistViewController.h
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checklist.h"
#import "ItemDetailViewController.h"

@class ChecklistViewController;
@protocol ChecklistViewControllerDelegate<NSObject>

-(void)ChecklistViewControllerDidBack:(ChecklistViewController *)controller;

@end

@interface ChecklistViewController : UITableViewController<ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;

@property(nonatomic,strong) id<ChecklistViewControllerDelegate> delegate;


@end
