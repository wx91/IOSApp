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

@property (nonatomic, assign) NSInteger checklistId;

@property (nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *iconName;

//@property(nonatomic,strong)RLMArray<ChecklistItem> *checklistitems;

@end
