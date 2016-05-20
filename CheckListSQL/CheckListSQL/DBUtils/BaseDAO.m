//
//  BaseDAO.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseDAO.h"
#define DB_FILE_NAME @"app.db"

@implementation BaseDAO

-(instancetype)init{
    self=[super init];
    if (self) {
        self.dbFilePath=[DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
        //初始化数据库
        DBHelper *dbHelper=[DBHelper new];
        [dbHelper initDB];
    }
    return self;
}

-(FMDatabase *)db{
    if ([self openDB]) {
        return db;
    }else{
        return nil;
    }
}

-(BOOL)openDB{
    db=[FMDatabase databaseWithPath:self.dbFilePath];
    if (![db open]) {
        [db close];
        NSLog(@"数据库打开失败。");
        return false;
    }
    return true;
}

@end
