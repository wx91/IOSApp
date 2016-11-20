//
//  ChecklistItemBL.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/19.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Checklist.h"
#import "ChecklistItem.h"
#import "ChecklistItemDAO.h"
@interface ChecklistItemService : NSObject

@property (nonatomic, strong) ChecklistItemDAO *checklistItemDAO;

//查询所用数据方法
-(NSMutableArray *)findAll;
//根据checklist查找item
-(NSMutableArray *) findByChecklist:(Checklist *)model;

-(ChecklistItem *)findChecklistById:(ChecklistItem *)model;

-(void)addChecklistItem:(ChecklistItem *)model;

-(void)changeChecklistItem:(ChecklistItem *)model;

-(void)deleteChecklistItem:(ChecklistItem *)model;
//查询分页
-(NSMutableArray *)findAllByPage:(NSInteger)currentPage withPageRow:(NSInteger)pageRow;
@end
