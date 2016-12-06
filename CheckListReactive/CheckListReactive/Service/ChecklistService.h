//
//  ChecklistBL.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/19.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Checklist.h"
#import "ChecklistDAO.h"
#import "ChecklistItemDAO.h"

@interface ChecklistService : NSObject

@property (nonatomic, strong) ChecklistDAO *checklistDAO;

@property (nonatomic, strong) ChecklistItemDAO *checklistItemDAO;


//查询所用数据方法
-(NSMutableArray *)findAll;

-(Checklist *)findChecklistById:(Checklist *)model;

-(void)addChecklist:(Checklist *)model;

-(void)changeChecklist:(Checklist *)model;

-(void)deleteChecklist:(Checklist *)model;
//查询分页
-(NSMutableArray *)findAllByPage:(NSInteger)currentPage withPageRow:(NSInteger)pageRow;
//计算没有被选中的代办事项
-(int)countUncheckedItems:(Checklist *)model;

@end
