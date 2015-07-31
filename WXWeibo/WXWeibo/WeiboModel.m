//
//  WeiboModel.m
//  WXWeibo
//
//  Created by wangx on 15/7/30.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "WeiboModel.h"
#import "UserModel.h"

@implementation WeiboModel

-(NSDictionary *)attributeMapDictionary{
    NSDictionary *mapAtt=@{
         @"createDate":@"created_at",
         @"weiboId":@"id",
         @"text":@"text",
         @"source":@"source",
         @"favorited":@"favorited",
         @"thumbnailImage":@"thumbnail_pic",
         @"bmiddleImage":@"bmiddle_pic",
         @"originalImage":@"original_pic",
         @"geo":@"geo",
         @"repostsCount":@"reposts_count",
         @"commentsCount":@"comments_count"
         
    };
    return mapAtt;
}

-(void)setAttributes:(NSDictionary *)dataDic{
    //将字典数据根据映射关系填充到当前对象的属性
    [self attributeMapDictionary];
    
    NSDictionary *retweenDic=[dataDic objectForKey:@"retweeted_status"];
    if (retweenDic!=nil) {
        WeiboModel *relweibo=[[WeiboModel alloc]initWithDataDic:retweenDic];
        self.relWeibo=relweibo;
    }
    
    NSDictionary *userDic=[dataDic objectForKey:@"user"];
    if (userDic!=nil) {
        UserModel *user=[[UserModel alloc]initWithDataDic:userDic];
        self.user=user;
    }
    
}

@end
