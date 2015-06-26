//
//  ChecklistItem.h
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) BOOL checked;

@property(nonatomic,assign) BOOL shouldRemind;

@property(nonatomic,copy)NSDate *dueDate;

- (void)toggleChecked;

@end
