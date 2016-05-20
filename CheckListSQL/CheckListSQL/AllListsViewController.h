//
//  UITableViewController.h
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "ChecklistViewController.h"

@interface AllListsViewController : UITableViewController<ListDetailViewControllerDelegate,ChecklistViewControllerDelegate>




@end
