//
//  Checklist.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "ChecklistItem.h"

@interface Checklist : RLMObject

@property NSString* checklistId;

@property NSString *name;

@property NSString *iconName;

@end
