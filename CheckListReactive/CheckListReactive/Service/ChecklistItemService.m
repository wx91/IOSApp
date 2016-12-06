//
//  ChecklistItemBL.m
//  CheckListSQL
//
//  Created by 王享 on 16/5/19.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "ChecklistItemService.h"
#import "ChecklistItemDAO.h"

@implementation ChecklistItemService

-(instancetype)init{
    self = [super init ];
    if (self) {
        _checklistItemDAO = [[ChecklistItemDAO alloc]init];
    }
    return self;
}
//查询所用数据方法
-(NSMutableArray *)findAll{
    NSMutableArray *list  = [_checklistItemDAO findAll];
    return list;
}
//根据checklist查找item
-(NSMutableArray *) findByChecklist:(Checklist *)model{
    NSMutableArray *list = [_checklistItemDAO findByChecklist:model];
    return list;
}

-(ChecklistItem *)findChecklistById:(ChecklistItem *)model{
    model = [_checklistItemDAO findById:model];
    return model;
}

-(void)addChecklistItem:(ChecklistItem *)model{
    [_checklistItemDAO create:model];
}

-(void)changeChecklistItem:(ChecklistItem *)model{
    [_checklistItemDAO modify:model];
}

-(void)deleteChecklistItem:(ChecklistItem *)model{
    [_checklistItemDAO remove:model];
}
//查询分页
-(NSMutableArray *)findAllByPage:(NSInteger)currentPage withPageRow:(NSInteger)pageRow{
    NSMutableArray *list=[_checklistItemDAO findAllByPage:currentPage withPageRow:pageRow];
    return list;
}
@end
