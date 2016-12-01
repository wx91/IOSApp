//
//  ChecklistDAO.m
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "ChecklistDAO.h"
#import "ChecklistItem.h"

@implementation ChecklistDAO

static ChecklistDAO *sharedManager=nil;

+ (ChecklistDAO *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super alloc]init];
    });
    return sharedManager;
}
//插入Checklist方法
-(int) create:(Checklist *)model{
    if ([self openRealm]) {
        [realm beginWriteTransaction];
        [realm addObject:model];
        [realm commitWriteTransaction];
    }
    return 0;
}
//删除Checklist方法
-(int) remove:(Checklist *)model{
    if ([self openRealm]) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"checklistId = %@",model.checklistId];
        RLMResults<ChecklistItem *> *checklistitems = [ChecklistItem objectsWithPredicate:pre];
        [realm beginWriteTransaction];
        //先删除子表（checklistItem）相关数据
        [realm deleteObjects:checklistitems];
        [realm deleteObjects:model];
        [realm commitWriteTransaction];
    }

    return 0;
}

//修改Checklist方法
-(int) modify:(Checklist *)model{
    if ([self openRealm]) {
        [realm beginWriteTransaction];
        [Checklist createOrUpdateInRealm:realm withValue:model];
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

//按照主键查询数据方法
-(Checklist *) findById:(Checklist *)model{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"checklistId = %@",model.checklistId];
    RLMResults<Checklist *> *checklistArray = [Checklist objectsWithPredicate:pre];
    Checklist *result = (Checklist *)[checklistArray firstObject];
    return result;
}
//查询所有数据方法
-(NSMutableArray *)findAllByPage:(NSInteger)currentPage withPageRow:(NSInteger)pageRow{
    NSMutableArray *listData =[NSMutableArray array];
    RLMResults<Checklist *> *checklists = [[Checklist allObjects] sortedResultsUsingProperty:@"checklistId" ascending:YES];
    for (NSInteger i = (currentPage-1)*pageRow; i<currentPage*pageRow; i++) {
        if (i < checklists.count) {
            Checklist *checklist = [checklists objectAtIndex:i];
            [listData addObject:checklist];
        }
    }
    return listData;
}


@end
