//
//  ChecklistItemDAO.m
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "ChecklistItemDAO.h"


@implementation ChecklistItemDAO

static ChecklistItemDAO *sharedManager=nil;

+ (ChecklistItemDAO *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super alloc]init];
    });
    return sharedManager;
}

//插入Checklist方法
-(int) create:(ChecklistItem *)model{
    if ([self openRealm]) {
        [realm beginWriteTransaction];
        [realm addObject:model];
        [realm commitWriteTransaction];
    }
    return 0;
}

//删除Checklist方法
-(int) remove:(ChecklistItem *)model{
    if ([self openRealm]) {
        [realm beginWriteTransaction];
        //先删除子表（checklistItem）相关数据
        [realm deleteObjects:model];
        [realm commitWriteTransaction];
    }
    return 0;
}

//修改Checklist方法
-(int) modify:(ChecklistItem *)model{
    if ([self openRealm]) {
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:model];
        [realm commitWriteTransaction];
    }
    return 0;
}

//查询所有数据方法
-(NSMutableArray *) findAll{
    NSMutableArray *listData =[NSMutableArray array];
    if ([self openRealm]) {
        RLMResults<Checklist *> *checklists = [Checklist allObjects];
        for (Checklist *checklist in checklists) {
            [listData addObject:checklist];
        }
    }
    return listData;
}
//根据checklist查找item
-(NSMutableArray *) findByChecklist:(Checklist *)model{
    NSMutableArray *listData =[NSMutableArray array];
    if ([self openRealm]) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"checklistId = %@",model.checklistId];
        RLMResults<ChecklistItem *> *checklistitems = [ChecklistItem objectsWithPredicate:pre];
        for (ChecklistItem *checklistitem in checklistitems) {
            [listData addObject:checklistitem];
        }
    }
    return listData;
}
//查询分页
-(NSMutableArray *)findAllByPage:(NSInteger)currentPage withPageRow:(NSInteger)pageRow{
    NSMutableArray *listData =[NSMutableArray array];
    if ([self openRealm]) {
        RLMResults<ChecklistItem *> *checklistItems = [[Checklist allObjects] sortedResultsUsingProperty:@"checklistItemID" ascending:YES];
        for (NSInteger i = currentPage*pageRow; i<(currentPage+1)*pageRow; i++) {
            if (i< checklistItems.count) {
                ChecklistItem *checklistitem = [checklistItems objectAtIndex:i];
                [listData addObject:checklistitem];
            }
        }
    }
    return listData;
}

//按照主键查询数据方法
-(ChecklistItem *) findById:(ChecklistItem *)model{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"checklistItemID = %@",model.checklistId];
    RLMResults<ChecklistItem *> *checklistArray = [ChecklistItem objectsWithPredicate:pre];
    ChecklistItem *result = (ChecklistItem *)[checklistArray firstObject];
    return result;
}


@end
