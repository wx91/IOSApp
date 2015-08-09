//
//  Status.m
//  CustomWeibo
//
//  Created by wangx on 15/8/9.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "Status.h"
#import "MJExtension.h"

@implementation Status
+ (NSDictionary *)replacedKeyFromPropertyName{
    NSDictionary *mapAtt = @{
                                 @"createDate":@"created_at",
                                 @"weiboId":@"id",
                                 @"text":@"text",
                                 @"source":@"source",
                                 @"favorited":@"favorited",
                                 @"thumbnailImage":@"thumbnail_pic",
                                 @"bmiddleImage":@"bmiddle_pic",
                                 @"originalImage":@"original_pic",
                                 @"repostsCount":@"reposts_count",
                                 @"commentsCount":@"comments_count",
                                 @"attitudesCount":@"attitudes_count"
                                 };
        
        return mapAtt;
}
//- (NSDictionary *)attributeMapDictionary {
//    NSDictionary *mapAtt = @{
//                             @"createDate":@"created_at",
//                             @"weiboId":@"id",
//                             @"text":@"text",
//                             @"source":@"source",
//                             @"favorited":@"favorited",
//                             @"thumbnailImage":@"thumbnail_pic",
//                             @"bmiddleImage":@"bmiddle_pic",
//                             @"originalImage":@"original_pic",
//                             @"geo":@"geo",
//                             @"repostsCount":@"reposts_count",
//                             @"commentsCount":@"comments_count",
//                             @"attitudesCount":@"attitudes_count"
//                             };
//    
//    return mapAtt;
//}
//
//-(void)setAttributes:(NSDictionary *)dataDic{
//    //将字典数据根据映射关系填充到当前对象的属性上。
//    [super setAttributes:dataDic];
//    
//    NSDictionary *retweetDic = [dataDic objectForKey:@"retweeted_status"];
//    if (retweetDic != nil) {
//        Status *relStatus = [[Status alloc] initWithDataDic:retweetDic];
//        self.relWeibo = relStatus;
//    }
//    
//    NSDictionary *userDic = [dataDic objectForKey:@"user"];
//    if (userDic != nil) {
//        User *user = [[User alloc] initWithDataDic:userDic];
//        self.user = user;
//    }
//}
@end


