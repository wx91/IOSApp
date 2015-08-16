//
//  BaseDAO.h
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "DBHelper.h"

@interface BaseDAO : NSObject{
    FMDatabase *db;
}
//数据文件全路径
@property(nonatomic, strong) NSString* dbFilePath;

//打开SQLite数据库 true 打开成功 false 打开失败
-(BOOL)openDB;

@end
