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
    RLMRealm *realm= [RLMRealm defaultRealm];
    RLMResults<ChecklistItem *> *checklistitems = [ChecklistItem objectsWhere:@"checklistId = %lu" args:model.checklistId];
    [realm beginWriteTransaction];
    //先删除子表（checklistItem）相关数据
    [realm deleteObjects:checklistitems];
    [realm deleteObjects:model];
    [realm commitWriteTransaction];
    return 0;
}

//修改Checklist方法
-(int) modify:(Checklist *)model{
//    if ([self openDB]) {
//        NSString *sqlStr =@"update Checklist set name=:name,iconName=:iconName where checklistId=:checklistId";
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        [params setObject:model.name forKey:@"name"];
//        [params setObject:model.iconName forKey:@"iconName"];
//        [params setObject:[NSNumber numberWithInteger:model.checklistId] forKey:@"checklistId"];
//        if (![db executeUpdate:sqlStr withParameterDictionary:params]) {
//            NSLog(@"修改数据失败!");
//        }
//    }
//    [db close];
    RLMRealm *realm= [RLMRealm defaultRealm];
    [realm addOrUpdateObject:model];
    [realm commitWriteTransaction];
    return 0;
    
}

//查询所有数据方法
-(NSMutableArray *) findAll{
    NSMutableArray *listData =[NSMutableArray array];
//    if ([self openDB]) {
//        NSString *sqlStr = @"select checklistId,name,iconName from Checklist ";
//        FMResultSet *rs = [db executeQuery:sqlStr];
//        while (rs.next) {
//            Checklist *model = [[Checklist alloc]init];
//            
//            int checklistId = [rs intForColumn:@"checklistId"];
//            model.checklistId=checklistId;
//            
//            NSString *name =[rs stringForColumn:@"name"];
//            model.name=name;
//            
//            NSString *iconName =[rs stringForColumn:@"iconName"];
//            model.iconName = iconName;
//            [listData addObject:model];
//        }
//    }
//    [db close];
    
    return listData;
}

//按照主键查询数据方法
-(Checklist *) findById:(Checklist*)model{
    if ([self openDB]) {
        NSString *sqlStr = @"select checklistId,name,iconName from Checklist where checklistId = :checklistId";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:model.checklistId] forKey:@"checklistId"];
        FMResultSet *rs = [db executeQuery:sqlStr withParameterDictionary:params];
        while (rs.next) {
            int checklistId = [rs intForColumn:@"checklistId"];
            model.checklistId=checklistId;
            
            NSString *name = [rs stringForColumn:@"name"];
            model.name=name;
            
            NSString *iconName = [rs stringForColumn:@"iconName"];
            model.iconName = iconName;
        }
    }
    [db close];
    return model;
}
//查询所有数据方法
-(NSMutableArray *)findAllByPage:(NSInteger)currentPage withPageRow:(NSInteger)pageRow{
    NSMutableArray *listData =[NSMutableArray array];
    if ([self openDB]) {
        NSString *sqlStr =[NSString stringWithFormat:@"select * from Checklist order by checklistId asc limit %lu offset %lu",pageRow,(currentPage-1)*pageRow];
        FMResultSet *rs = [db executeQuery:sqlStr];
        while (rs.next) {
            Checklist *model = [[Checklist alloc]init];
            
            int checklistId = [rs intForColumn:@"checklistId"];
            model.checklistId=checklistId;
            
            NSString *name =[rs stringForColumn:@"name"];
            model.name=name;
            
            NSString *iconName =[rs stringForColumn:@"iconName"];
            model.iconName = iconName;
            [listData addObject:model];
        }
    }
    [db close];
    return listData;
}


@end
