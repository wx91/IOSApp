//
//  ChecklistBL.m
//  CheckListSQL
//
//  Created by 王享 on 16/5/19.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "ChecklistService.h"
#import "ChecklistDAO.h"
#import "ChecklistItem.h"
#import "ChecklistItemDAO.h"
@implementation ChecklistService
//查询所用数据方法
-(instancetype)init{
    self = [super init];
    if (self) {
        _checklistDAO = [[ChecklistDAO alloc]init];
        _checklistItemDAO = [[ChecklistItemDAO alloc]init];
    }
    return self;
}
-(NSMutableArray*)findAll{
    NSMutableArray* list  = [_checklistDAO findAll];
    return list;
}

-(Checklist *)findChecklistById:(Checklist *)model{
    model  = [_checklistDAO findById:model];
    return model;
}

-(void)addChecklist:(Checklist *)model{
    [_checklistDAO create:model];
}

-(void)changeChecklist:(Checklist *)model{
    [_checklistDAO modify:model];
}

-(void)deleteChecklist:(Checklist *)model{
    [_checklistDAO remove:model];
}
//查询分页
-(NSMutableArray *)findAllByPage:(NSInteger)currentPage withPageRow:(NSInteger)pageRow{
    NSMutableArray *list = [_checklistDAO findAllByPage:currentPage withPageRow:pageRow];
    return list;
}

-(int)countUncheckedItems:(Checklist *)model{
    NSMutableArray *items = [_checklistItemDAO findByChecklist:model];
    int count = 0;
    for(ChecklistItem *item in items){
        if(!item.checked){
            count+=1;
        }
    }
    return count;
}

@end
