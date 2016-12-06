//
//  IconPickerViewControllerTableViewController.h
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;
@protocol IconPickerViewControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString*)iconName;

@end

@interface IconPickerViewController : UITableViewController

@property(nonatomic,strong) NSArray *icons;

@property(nonatomic,weak)id <IconPickerViewControllerDelegate> delegate;

@end
