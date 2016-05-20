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
-(NSMutableArray*)findAll{
    ChecklistDAO *dao = [ChecklistDAO sharedManager];
    NSMutableArray* list  = [dao findAll];
    return list;
}

-(Checklist *)findChecklistById:(Checklist *)model{
    ChecklistDAO *dao = [ChecklistDAO sharedManager];
    model  = [dao findById:model];
    return model;
}

-(void)addChecklist:(Checklist *)model{
    ChecklistDAO *dao = [ChecklistDAO sharedManager];
    [dao create:model];
}

-(void)changeChecklist:(Checklist *)model{
    ChecklistDAO *dao = [ChecklistDAO sharedManager];
    [dao modify:model];
}

-(void)deleteChecklist:(Checklist *)model{
    ChecklistDAO *dao = [ChecklistDAO sharedManager];
    [dao remove:model];
}

-(int)countUncheckedItems:(Checklist *)model{
    ChecklistItemDAO *dao = [ChecklistItemDAO sharedManager];
    NSMutableArray *items = [dao findByChecklist:model];
    int count = 0;
    for(ChecklistItem *item in items){
        if(!item.checked){
            count+=1;
        }
    }
    return count;
}

@end
