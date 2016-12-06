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
    if ([self openDB]) {
        NSString *sqlStr = @"insert into ChecklistItem(context,checked,shouldRemind,dueDate,checklistId) values (:context,:checked,:shouldRemind,:dueDate,:checklistId)";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:model.context forKey:@"context"];
        [params setObject:[NSNumber numberWithBool:model.checked] forKey:@"checked"];
        [params setObject:[NSNumber numberWithBool:model.shouldRemind] forKey:@"shouldRemind"];
        [params setObject:model.dueDate forKey:@"dueDate"];
        [params setObject:[NSNumber numberWithInteger:model.checklistId] forKey:@"checklistId"];
        if (![db executeUpdate:sqlStr withParameterDictionary:params]) {
            NSLog(@"插入数据失败。");
        }
    }
    [db close];
    return 0;
}

//删除Checklist方法
-(int) remove:(ChecklistItem *)model{
    if ([self openDB]) {
        NSString *sqlStr = [NSString stringWithFormat:@"delete from ChecklistItem  where checklistItemID = %lu",model.checklistItemID];
        if (![db executeUpdate:sqlStr]) {
            NSLog(@"删除数据失败！");
        }
        [db close];
    }
    return 0;
}

//修改Checklist方法
-(int) modify:(ChecklistItem *)model{
    if ([self openDB]) {
        NSString *sqlStr = @"update ChecklistItem set context=:context,checked=:checked,shouldRemind=:shouldRemind,dueDate=:dueDate where checklistItemID=:checklistItemID";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:model.context forKey:@"context"];
        [params setObject:[NSNumber numberWithBool:model.checked] forKey:@"checked"];
        [params setObject:[NSNumber numberWithBool:model.shouldRemind] forKey:@"shouldRemind"];
        [params setObject:model.dueDate forKey:@"dueDate"];
        [params setObject:[NSNumber numberWithInteger:model.checklistItemID] forKey:@"checklistItemID"];
        if (![db executeUpdate:sqlStr withParameterDictionary:params ]) {
            NSLog(@"修改数据失败！");
        }
    }
    [db close];
    return 0;
}

//查询所有数据方法
-(NSMutableArray *) findAll{
    NSMutableArray *listData = [NSMutableArray array];
    if ([self openDB]) {
        NSString *sqlStr = @"select checklistItemID, context,checked,shouldRemind,dueDate,checklistId from ChecklistItem";
        FMResultSet *rs = [db executeQuery:sqlStr];
        while (rs.next) {
            ChecklistItem *checklistItem = [[ChecklistItem alloc] init];
            
            int checklistItemID =[rs intForColumn:@"checklistItemID"];
            checklistItem.checklistItemID = checklistItemID;
            
            NSString *context = [rs stringForColumn:@"context"];
            checklistItem.context = context;
            
            BOOL checked = [rs boolForColumn:@"checked"];
            checklistItem.checked=checked;
            
            BOOL shouldRemind =[rs boolForColumn:@"shouldRemind"];
            checklistItem.shouldRemind = shouldRemind;
            
            NSDate *dueDate = [rs dateForColumn:@"dueDate"];
            checklistItem.dueDate = dueDate;
            
            int checklistId =[rs intForColumn:@"checklistId"];
            checklistItem.checklistId = checklistId;
            
            [listData addObject:checklistItem];
        }
    }
    [db close];
    return listData;
}
//根据checklist查找item
-(NSMutableArray *) findByChecklist:(Checklist *)model{
    NSMutableArray *listData = [NSMutableArray array];
    if ([self openDB]) {
        NSString *sqlStr = @"select checklistItemID,context,checked,shouldRemind,dueDate,checklistId from ChecklistItem where checklistId = :checklistId";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:model.checklistId] forKey:@"checklistId"];
        FMResultSet *rs = [db executeQuery:sqlStr withParameterDictionary:params];
        while (rs.next) {
            ChecklistItem *item = [[ChecklistItem alloc]init];
            
            int checklistItemID =[rs intForColumn:@"checklistItemID"];
            item.checklistItemID =checklistItemID;
            
            NSString *context = [rs stringForColumn:@"context"];
            item.context = context;
            
            BOOL checked = [rs boolForColumn:@"checked"];
            item.checked=checked;
            
            BOOL shouldRemind =[rs boolForColumn:@"shouldRemind"];
            item.shouldRemind = shouldRemind;
            
            NSDate *dueDate = [rs dateForColumn:@"dueDate"];
            item.dueDate = dueDate;
            
            int checklistId =[rs intForColumn:@"checklistId"];
            item.checklistId = checklistId;
            [listData addObject:item];
        }
    }
    [db close];
    return listData;
}
//查询分页
-(NSMutableArray *)findAllByPage:(NSInteger)currentPage withPageRow:(NSInteger)pageRow{
    NSMutableArray *listData =[NSMutableArray array];
    if ([self openDB]) {
        NSString *sqlStr =[NSString stringWithFormat:@"select * from ChecklistItem order by checklistItemID asc limit %lu offset %lu",pageRow,(currentPage-1)*pageRow];
        FMResultSet *rs = [db executeQuery:sqlStr];
        while (rs.next) {
            ChecklistItem *item = [[ChecklistItem alloc]init];
            
            int checklistItemID =[rs intForColumn:@"checklistItemID"];
            item.checklistItemID =checklistItemID;
            
            NSString *context = [rs stringForColumn:@"context"];
            item.context = context;
            
            BOOL checked = [rs boolForColumn:@"checked"];
            item.checked=checked;
            
            BOOL shouldRemind =[rs boolForColumn:@"shouldRemind"];
            item.shouldRemind = shouldRemind;
            
            NSDate *dueDate = [rs dateForColumn:@"dueDate"];
            item.dueDate = dueDate;
            
            int checklistId =[rs intForColumn:@"checklistId"];
            item.checklistId = checklistId;
            [listData addObject:item];
        }
    }
    [db close];
    return listData;
}

//按照主键查询数据方法
-(ChecklistItem *) findById:(ChecklistItem *)model{
    if ([self openDB]) {
        NSString *sqlStr = @"select checklistItemID,context,checked,shouldRemind,dueDate,checklistId from ChecklistItem where checklistItemID = :checklistItemID";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:model.checklistItemID] forKey:@"checklistItemID"];
        FMResultSet *rs = [db executeQuery:sqlStr withParameterDictionary:params];
        while (rs.next) {
            int checklistItemID =[rs intForColumn:@"checklistItemID"];
            model.checklistItemID =checklistItemID;
            
            NSString *context = [rs stringForColumn:@"context"];
            model.context = context;
            
            BOOL checked = [rs boolForColumn:@"checked"];
            model.checked=checked;
            
            BOOL shouldRemind =[rs boolForColumn:@"shouldRemind"];
            model.shouldRemind = shouldRemind;
            
            NSDate *dueDate = [rs dateForColumn:@"dueDate"];
            model.dueDate = dueDate;
            
            int checklistId =[rs intForColumn:@"checklistId"];
            model.checklistId = checklistId;
        }
    }
    [db close];
    return model;
}


@end
