//
//  EventsBL.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "EventsBL.h"
#import "EventsDAO.h"

@implementation EventsBL
//查询所用数据方法
-(NSMutableArray*) readData{
    EventsDAO *dao = [EventsDAO sharedManager];
    NSMutableArray* list  = [dao findAll];
    return list;
}

@end
