//
//  DBHelper.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DBHelper : NSObject{
    FMDatabase *db;
}
//获取沙盒Document目录下的全路径
+(NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName;
//初始化并加载数据
-(void)initDB;
//从数据库获取当前数据库版本号
-(int)dbVersionNumber;
//是否存在该表
+(BOOL) isTableOK:(NSString *)tableName withDB:(FMDatabase *)db;

@end
