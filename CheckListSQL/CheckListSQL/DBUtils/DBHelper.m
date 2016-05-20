//
//  DBHelper.m
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "DBHelper.h"
#define DB_FILE_NAME @"app.db"

@implementation DBHelper

+(NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName{
    //NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *documentDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path=[documentDirectory stringByAppendingPathComponent:fileName];
    return path;
}


//初始化并加载数据
-(void)initDB{
    NSString* configTablePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"DBConfig" ofType:@"plist"];
    NSLog(@"configTablePath = %@",configTablePath);
    NSDictionary *configTable=[[NSDictionary alloc]initWithContentsOfFile:configTablePath];
    //从配置文件获取数据库版本号
    NSNumber *dbVersion=[configTable objectForKey:@"DB_VERSION"];
    if (dbVersion==nil) {
        dbVersion=[NSNumber numberWithInt:0];
    }
    //从数据库DBVersionInfo表记录返回的数据库版本号
    int versionNumber=[self dbVersionNumber];
    //版本号不一致
    if ([dbVersion intValue]!=versionNumber ) {
        NSString *dbFilePath=[DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
        db=[FMDatabase databaseWithPath:dbFilePath];
        if (![db open]) {
            [db close];
            NSLog(@"数据库打开失败！");
        }else{
            //加载数据到业务表
            NSLog(@"数据库升级....");
            NSString* configTablePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"create_load" ofType:@"sql"];
            NSString *sql=[[NSString alloc]initWithContentsOfFile:configTablePath encoding:NSUTF8StringEncoding error:nil];
            if (![db executeUpdate:sql]) {
                NSLog(@"数据库升级失败！");
            }
            //把版本会写到文件中
            NSString* usql = [[NSString alloc] initWithFormat: @"update  DBVersionInfo set version_number = %i", [dbVersion intValue]];
            if (![ db executeUpdate:usql]) {
                NSLog(@"更新DBVersionInfo数据失败。");
            }
            [db close];
        }
    }
}

-(int)dbVersionNumber{
    int versionNubmer = -1;
    NSString* dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
    db=[FMDatabase databaseWithPath:dbFilePath];
    if (![db open]) {
        [db close];
        NSLog(@"数据库打开失败！");
    }else{
        NSString* sql = @"create table if not exists DBVersionInfo ( version_number int );";
        if (![db executeUpdate:sql]) {
            NSLog(@"创建表失败！");
        }
        NSString* qsql = @"select version_number from DBVersionInfo";
        FMResultSet *rs=[db executeQuery:qsql];
        if (rs.next) {//如果有下一条
            versionNubmer=[rs intForColumn:@"version_number"];
        }else{
            NSLog(@"无数据情况");
            NSString* csql = @"insert into DBVersionInfo (version_number) values(-1)";
            if (![db executeUpdate:csql]) {
                NSLog(@"插入数据失败。");
            }
        }
        [db close];
    }
    return versionNubmer;
}

+ (BOOL) isTableOK:(NSString *)tableName withDB:(FMDatabase *)db
{
    BOOL isOK = NO;
    
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count)
        {
            isOK =  NO;
        }
        else
        {
            isOK = YES;
        }
    }
    [rs close];
    
    return isOK;
}
@end
