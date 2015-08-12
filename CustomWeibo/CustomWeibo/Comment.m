//
//  Comment.m
//  CustomWeibo
//
//  Created by wangx on 15/8/9.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "Comment.h"

@implementation Comment

+ (NSDictionary *)replacedKeyFromPropertyName{
    NSDictionary *mapAtrr=@{
                            @"commentId":@"id",
                            @"createDate":@"created_at"};
    return mapAtrr;
}

@end
