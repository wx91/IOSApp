//
//  ScheduleDAO.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "ScheduleDAO.h"

@implementation ScheduleDAO

static ScheduleDAO *sharedManager = nil;

+ (ScheduleDAO*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

//插入Schedule方法
-(int) create:(Schedule*)model{
    if ([self openDB]) {
        NSString *sqlStr = @"INSERT INTO Schedule (GameDate, GameTime,GameInfo,EventID) VALUES (?,?,?,?)";
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        [params setObject:model.GameDate forKey:@"GameDate"];
        [params setObject:model.GameTime forKey:@"GameTime"];
        [params setObject:model.GameInfo forKey:@"GameInfo"];
        [params setObject:[NSNumber numberWithUnsignedInteger:model.Event.EventID] forKey:@"EventID"];
        if (![db executeUpdate:sqlStr withParameterDictionary:params]) {
            NSLog(@"插入数据失败。");
        }
    }
    [db close];
    return 0;
}
//删除Schedule方法
-(int) remove:(Schedule*)model{
    if ([self openDB]) {
        NSString *sqlStr = @"DELETE  from Schedule where ScheduleID =?";
        NSNumber *ScheduleID=[NSNumber numberWithUnsignedInteger:*(model.ScheduleID)];
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        [params setObject:ScheduleID forKey:@"ScheduleID"];
        if ([db executeUpdate:sqlStr withParameterDictionary:params]) {
            NSLog(@"删除数据失败。");
        }
        [db close];
    }
    return 0;
}

//修改Schedule方法
-(int) modify:(Schedule*)model{
    if ([self openDB]) {
        NSString *sqlStr = @"UPDATE Schedule set GameInfo=?,EventID=?,GameDate =?, GameTime=? where ScheduleID=?";
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        [params setObject:model.GameInfo forKey:@"GameInfo"];
        [params setObject:[NSNumber numberWithUnsignedInteger:model.Event.EventID]
                   forKey:@"EventID"];
        [params setObject:model.GameDate forKey:@"GameDate"];
        [params setObject:model.GameTime forKey:@"GameTime"];
        [params setObject:[NSNumber numberWithUnsignedInteger:*(model.ScheduleID)]
                   forKey:@"ScheduleID"];
        if(![db executeUpdate:sqlStr withParameterDictionary:params]){
            NSLog(@"修改数据失败。");
        }
        [db close];
    }
    return 0;
}
//查询所有数据方法
-(NSMutableArray*) findAll{
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    if ([self openDB]) {
        NSString *qsql = @"SELECT GameDate, GameTime,GameInfo,EventID,ScheduleID FROM Schedule";
        FMResultSet *rs=[db executeQuery:qsql];
        while (rs.next) {
            Schedule* schedule = [[Schedule alloc] init];
            Events *event  = [[Events alloc] init];
            schedule.Event = event;
            
            NSString *GameDate=[rs stringForColumn:@"GameDate"];
            schedule.GameDate=GameDate;
            
            NSString *GameTime=[rs stringForColumn:@"GameTime"];
            schedule.GameTime=GameTime;
            
            NSString *GameInfo=[rs stringForColumn:@"GameInfo"];
            schedule.GameInfo=GameInfo;
            
            NSUInteger EventID=[rs intForColumn:@"EventID"];
            schedule.Event.EventID=EventID;
            
            NSUInteger ScheduleID=[rs intForColumn:@"ScheduleID"];
            schedule.ScheduleID=&(ScheduleID);
            
            [listData addObject:schedule];
        }
    }
    [db close];
    return listData;
}
//按照主键查询数据方法
-(Schedule*) findById:(Schedule*)model{
    if ([self openDB]) {
        NSString *qsql = @"SELECT GameDate, GameTime,GameInfo,EventID,ScheduleID FROM Schedule where ScheduleID=?";
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        
        FMResultSet *rs=[db executeQuery:qsql withParameterDictionary:params];
        while (rs.next) {
            Schedule* schedule = [[Schedule alloc] init];
            Events *event  = [[Events alloc] init];
            schedule.Event = event;
            
            NSString *GameDate=[rs stringForColumn:@"GameDate"];
            schedule.GameDate=GameDate;
            
            NSString *GameTime=[rs stringForColumn:@"GameTime"];
            schedule.GameTime=GameTime;
            
            NSString *GameInfo=[rs stringForColumn:@"GameInfo"];
            schedule.GameInfo=GameInfo;
            
            NSUInteger EventID=[rs intForColumn:@"EventID"];
            schedule.Event.EventID=EventID;
            
            NSUInteger ScheduleID=[rs intForColumn:@"ScheduleID"];
            schedule.ScheduleID=&(ScheduleID);
            
            return schedule;
        }
    }
    [db close];
    return nil;
}
@end
