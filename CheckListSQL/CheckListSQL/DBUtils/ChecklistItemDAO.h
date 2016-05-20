//
//  ChecklistItemDAO.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "BaseDAO.h"
#import "ChecklistItem.h"
#import "Checklist.h"
@interface ChecklistItemDAO : BaseDAO

+ (ChecklistItemDAO *)sharedManager;

//插入Checklist方法
-(int) create:(ChecklistItem *)model;

//删除Checklist方法
-(int) remove:(ChecklistItem *)model;

//修改Checklist方法
-(int) modify:(ChecklistItem *)model;

//查询所有数据方法
-(NSMutableArray *) findAll;

//根据checklist查找item
-(NSMutableArray *) findByChecklist:(Checklist *)model;

//按照主键查询数据方法
-(ChecklistItem *) findById:(ChecklistItem *)model;



@end
