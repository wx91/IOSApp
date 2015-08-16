//
//  ScheduleBL.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "ScheduleBL.h"
#import "ScheduleDAO.h"
#import "EventsDAO.h"

@implementation ScheduleBL

//查询所用数据方法
-(NSMutableDictionary*) readData{
    ScheduleDAO *scheduleDAO = [ScheduleDAO sharedManager];
    
    NSMutableArray* schedules  = [scheduleDAO findAll];
    NSMutableDictionary *resDict = [[NSMutableDictionary alloc] init];
    
    EventsDAO *eventsDAO = [EventsDAO sharedManager];
    
    //延迟加载Events数据
    for (Schedule *schedule in schedules) {
        Events *event = [eventsDAO findById:schedule.Event];
        schedule.Event = event;
        
        NSArray  *allkey = [resDict allKeys];
        
        //把NSMutableArray结构转化为NSMutableDictionary结构
        if([allkey containsObject:schedule.GameDate]) {
            NSMutableArray* value = [resDict objectForKey:schedule.GameDate];
            [value addObject:schedule];
        } else {
            NSMutableArray* value = [[NSMutableArray alloc] init];
            [value addObject:schedule];
            [resDict setObject:value forKey:schedule.GameDate];
        }
        
    }
    
    return resDict;
}
@end
