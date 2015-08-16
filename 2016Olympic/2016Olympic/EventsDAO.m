//
//  EventsDAO.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "EventsDAO.h"
#import "Events.h"

@implementation EventsDAO

static EventsDAO *shareManager=nil;

+(EventsDAO *)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareManager=[[super alloc]init];
        
    });
    return shareManager;
}

//插入Events方法
-(int)create:(Events *)model{
    if ([self openDB]) {
        NSString *sqlStr = @"INSERT INTO Events (EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo) VALUES (?,?,?,?,?)";
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        [params setObject:model.EventName forKey:@"EventName"];
        [params setObject:model.EventIcon forKey:@"EventIcon"];
        [params setObject:model.KeyInfo forKey:@"KeyInfo"];
        [params setObject:model.BasicsInfo forKey:@"BasicsInfo"];
        [params setObject:model.OlympicInfo forKey:@"OlympicInfo"];
        if (![db executeUpdate:sqlStr withParameterDictionary:params]) {
            NSLog(@"插入数据失败。");
        }
    }
    [db close];
    return 0;
}

//删除Events方法
-(int) remove:(Events*)model{
    if ([self openDB]) {
        //先删除子表（比赛日程表）相关数据
        NSString *sqlScheduleStr = [[NSString alloc] initWithFormat: @"DELETE  from Schedule where EventID=%lu",model.EventID];
        //开启事务，立刻提交之前事务
        [db beginTransaction];
        if (![db executeUpdate:sqlScheduleStr]) {
            //回滚事务
            [db rollback];
            NSLog(@"删除数据失败。");
        }
        //先删除主表（比赛项目）数据
        NSString *sqlEventsStr = [[NSString alloc] initWithFormat: @"DELETE  from Events where EventID =%lu;",(unsigned long)model.EventID];
        if (![db executeUpdate:sqlEventsStr]) {
            //回滚事务
            [db rollback];
            NSLog(@"删除数据失败。");
        }
        //提交事务
        [db commit];
        [db close];
    }
    return 0;
}

//修改Events方法
-(int) modify:(Events*)model{
    if ([self openDB]) {
        NSString *sqlStr = @"UPDATE Events set EventName=?, EventIcon=?,KeyInfo=?,BasicsInfo=?,OlympicInfo=? where EventID =?";
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        [params setObject:model.EventName forKey:@"EventName"];
        [params setObject:model.EventIcon forKey:@"EventIcon"];
        [params setObject:model.KeyInfo forKey:@"KeyInfo"];
        [params setObject:model.BasicsInfo forKey:@"BasicsInfo"];
        [params setObject:model.OlympicInfo forKey:@"OlympicInfo"];
        [params setObject:[NSNumber numberWithUnsignedInteger:model.EventID]
                   forKey:@"EventID"];
        if (![db executeUpdate:sqlStr]) {
            NSLog(@"修改数据失败。");
        }
    }
    [db close];
    return 0;
}
//查询所有数据方法
-(NSMutableArray*) findAll{
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    if ([self openDB]) {
        NSString *qsql = @"SELECT EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events";
        FMResultSet *rs=[db executeQuery:qsql];
        while (rs.next) {
            Events* events = [[Events alloc] init];
            
            NSString *EventName=[rs stringForColumn:@"EventName"];
            events.EventName=EventName;
            
            NSString *EventIcon=[rs stringForColumn:@"EventIcon"];
            events.EventIcon=EventIcon;
            
            NSString *KeyInfo=[rs stringForColumn:@"KeyInfo"];
            events.KeyInfo=KeyInfo;
            
            NSString *BasicsInfo=[rs stringForColumn:@"BasicsInfo"];
            events.BasicsInfo=BasicsInfo;
            
            NSString *OlympicInfo=[rs stringForColumn:@"OlympicInfo"];
            events.OlympicInfo=OlympicInfo;
            
            NSUInteger EventID=[rs intForColumn:@"EventID"];
            events.EventID=EventID;
            [listData addObject:events];
        }
    }
    [db close];
    return listData;
}
//按照主键查询数据方法
-(Events*) findById:(Events*)model{
    if ([self openDB]) {
        NSString *qsql = @"SELECT EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events  where EventID =:EventID";
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithUnsignedInteger:model.EventID] forKey:@"EventID"];
        FMResultSet *rs=[db executeQuery:qsql withParameterDictionary:params];
        while (rs.next) {
            Events* events = [[Events alloc] init];
            
            NSString *EventName=[rs stringForColumn:@"EventName"];
            events.EventName=EventName;
            
            NSString *EventIcon=[rs stringForColumn:@"EventIcon"];
            events.EventIcon=EventIcon;
            
            NSString *KeyInfo=[rs stringForColumn:@"KeyInfo"];
            events.KeyInfo=KeyInfo;
            
            NSString *BasicsInfo=[rs stringForColumn:@"BasicsInfo"];
            events.BasicsInfo=BasicsInfo;
            
            NSString *OlympicInfo=[rs stringForColumn:@"OlympicInfo"];
            events.OlympicInfo=OlympicInfo;
            
            NSUInteger EventID=[rs intForColumn:@"EventID"];
            events.EventID=EventID;
            return events;
        }
    }
    [db close];
    return nil;
}
@end
