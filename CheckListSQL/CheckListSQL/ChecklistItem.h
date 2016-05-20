//
//  ChecklistItem.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject

@property (nonatomic, assign) NSInteger checklistItemID;

@property (nonatomic, copy) NSString *context;

@property (nonatomic, assign) BOOL checked;

@property(nonatomic,assign) BOOL shouldRemind;

@property(nonatomic,copy)NSDate *dueDate;

@property (nonatomic, assign) NSInteger checklistId;

@end
