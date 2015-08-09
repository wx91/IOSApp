//
//  User.m
//  CustomWeibo
//
//  Created by wangx on 15/8/9.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "User.h"

@implementation User
+ (NSDictionary *)replacedKeyFromPropertyName{
        NSDictionary *mapAtrr=@{
                                @"user_description":@"description"
                                };
        return mapAtrr;
}
//- (NSDictionary *)attributeMapDictionary {
//    NSDictionary *mapAtrr=@{
//                            @"user_description":@"description"
//                            };
//    return mapAtrr;
//}

@end
