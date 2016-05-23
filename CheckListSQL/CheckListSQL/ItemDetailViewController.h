//
//  ItemDetailViewController.h
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"


@interface ItemDetailViewController : UITableViewController

@property (nonatomic, strong) ChecklistItem *itemToEdit;

@end
