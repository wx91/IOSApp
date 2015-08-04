//
//  CommentModel.m
//  WXWeibo
//
//  Created by wangx on 15/8/4.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

-(void)setAttributes:(NSDictionary *)dataDic{
    [super setAttributes:dataDic];
    NSDictionary *userDic=[dataDic objectForKey:@"user"];
    NSDictionary *statusDic=[dataDic objectForKey:@"status"];
    
    UserModel *user=[[UserModel alloc]initWithDataDic:userDic];
    WeiboModel *weibo=[[WeiboModel alloc]initWithDataDic:statusDic];
    
    self.user=user;
    self.weibo=weibo;
    
}
@end
