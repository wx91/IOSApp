//
//  ChecklistItem.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface ChecklistItem : RLMObject

@property NSString *checklistItemID;

@property NSString *context;

@property BOOL checked;

@property BOOL shouldRemind;

@property NSDate *dueDate;

@property  NSString *checklistId;

@end
