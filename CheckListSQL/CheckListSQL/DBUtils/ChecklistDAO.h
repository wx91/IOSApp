//
//  ChecklistDAO.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "BaseDAO.h"
#import "Checklist.h"
@interface ChecklistDAO : BaseDAO

+ (ChecklistDAO *)sharedManager;

//插入Checklist方法
-(int) create:(Checklist *)model;

//删除Checklist方法
-(int) remove:(Checklist *)model;

//修改Checklist方法
-(int) modify:(Checklist *)model;

//查询所有数据方法
-(NSMutableArray *) findAll;

//按照主键查询数据方法
-(Checklist *) findById:(Checklist*)model;
//查询分页
-(NSMutableArray *)findAllByPage:(NSInteger)currentPage withPageRow:(NSInteger)pageRow;

@end
