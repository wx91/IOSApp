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
    if([self openDB]){
        NSString *sqlStr = @"insert into Checklist(name,iconName) values (:name,:iconName)";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:model.name forKey:@"name"];
        [params setObject:model.iconName forKey:@"iconName"];
        if (![db executeUpdate:sqlStr withParameterDictionary:params]) {
            NSLog(@"插入数据失败。");
        }
        [db close];
    }
    return 0;
}
//删除Checklist方法
-(int) remove:(Checklist *)model{
    if ([self openDB]) {
        //先删除子表（checklistItem）相关数据
        NSString *sqlItem = [NSString stringWithFormat:@"delete from ChecklistItem where checklistId = %lu",model.checklistId];
        //开启事务，立刻提交之前事务
        [db beginTransaction];
        if (![db executeUpdate:sqlItem]) {
            //回滚事务
            [db rollback];
            NSLog(@"删除数据失败");
        }
        //删除主表的数据
        NSString *sqlChecklist = [NSString stringWithFormat:@"delete from Checklist where checklistId =%lu",model.checklistId];
        if (![db executeUpdate:sqlChecklist]) {
            //回滚事务
            [db rollback];
            NSLog(@"删除数据失败!");
        }
        //提交事务
        [db commit];
        [db close];
    }
    return 0;
}

//修改Checklist方法
-(int) modify:(Checklist *)model{
    if ([self openDB]) {
        NSString *sqlStr =@"update Checklist set name=:name,iconName=:iconName where checklistId=:checklistId";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:model.name forKey:@"name"];
        [params setObject:model.iconName forKey:@"iconName"];
        [params setObject:[NSNumber numberWithInteger:model.checklistId] forKey:@"checklistId"];
        if (![db executeUpdate:sqlStr withParameterDictionary:params]) {
            NSLog(@"修改数据失败!");
        }
    }
    [db close];
    return 0;
}

//查询所有数据方法
-(NSMutableArray *) findAll{
    NSMutableArray *listData =[NSMutableArray array];
    if ([self openDB]) {
        NSString *sqlStr = @"select checklistId,name,iconName from Checklist ";
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


@end
