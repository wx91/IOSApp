//
//  DBHelper.h
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "FMDB.h"

#define DB_FILE_NAME @"app.db"

@interface DBHelper : NSObject{
    FMDatabase *db;
}
//获取沙盒Document目录下的全路径
+(NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName;
//初始化并加载数据
-(void)initDB;
//从数据库获取当前数据库版本号
-(int)dbVersionNumber;

@end
