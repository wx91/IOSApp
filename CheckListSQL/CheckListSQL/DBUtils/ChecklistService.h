//
//  ChecklistBL.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/19.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Checklist.h"
@interface ChecklistService : NSObject
//查询所用数据方法
-(NSMutableArray *)findAll;

-(Checklist *)findChecklistById:(Checklist *)model;

-(void)addChecklist:(Checklist *)model;

-(void)changeChecklist:(Checklist *)model;

-(void)deleteChecklist:(Checklist *)model;
//计算没有被选中的代办事项
-(int)countUncheckedItems:(Checklist *)model;

@end
