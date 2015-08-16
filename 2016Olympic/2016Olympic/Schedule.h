//
//  Schedule.h
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Events.h"
//比赛日程表 实体类
@interface Schedule : NSObject
//编号
@property(nonatomic,assign)NSUInteger *ScheduleID;
//比赛日期
@property(nonatomic,strong)NSString *GameDate;
//比赛时间
@property(nonatomic,strong)NSString *GameTime;
//比赛描述
@property(nonatomic,strong)NSString *GameInfo;
//比赛项目
@property(nonatomic,strong)Events *Event;

@end
