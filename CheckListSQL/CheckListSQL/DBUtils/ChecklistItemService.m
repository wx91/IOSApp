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
//查询所用数据方法
-(NSMutableArray *)findAll{
    ChecklistItemDAO *dao = [ChecklistItemDAO sharedManager];
    NSMutableArray *list  = [dao findAll];
    return list;
}
//根据checklist查找item
-(NSMutableArray *) findByChecklist:(Checklist *)model{
    ChecklistItemDAO *dao = [ChecklistItemDAO sharedManager];
    NSMutableArray *list = [dao findByChecklist:model];
    return list;
}

-(ChecklistItem *)findChecklistById:(ChecklistItem *)model{
    ChecklistItemDAO *dao = [ChecklistItemDAO sharedManager];
    model = [dao findById:model];
    return model;
}

-(void)addChecklistItem:(ChecklistItem *)model{
    ChecklistItemDAO *dao = [ChecklistItemDAO sharedManager];
    [dao create:model];
}

-(void)changeChecklistItem:(ChecklistItem *)model{
    ChecklistItemDAO *dao = [ChecklistItemDAO sharedManager];
    [dao modify:model];
}

-(void)deleteChecklistItem:(ChecklistItem *)model{
    ChecklistItemDAO *dao = [ChecklistItemDAO sharedManager];
    [dao remove:model];
}
@end
