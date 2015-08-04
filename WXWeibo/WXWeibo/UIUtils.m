//
//  UIUtils.m
//  WXTime
//
//  Created by wei.chen on 12-7-22.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联ios开发培训中心 All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "UIUtils.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"

@implementation UIUtils

+ (NSString *)getDocumentsPath:(NSString *)fileName {
    
    //两种获取document路径的方式
//    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    
    return path;
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	[formatter release];
	return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
}

+(NSString *)parseLink:(NSString *)text{

    NSString *regex=@"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
    NSArray *matchArray=[text componentsSeparatedByRegex:regex];
    for (NSString *linkString in matchArray) {
        //三种不同形式的超链接
        //<a href='user'://@用户><a>
        //<a href='http://www.baidu.com'>http://www.baodu.com</a>
        //<a href='topic://#话题#'>#话题#<a>
        
        NSString *replacing=nil;
        if ([linkString hasPrefix:@"@"]) {
            linkString=[linkString URLEncodedString];
            replacing=[NSString stringWithFormat:@"<a href='user://%@'>%@</a>",[linkString  URLEncodedString],linkString];
        }else if ([linkString hasPrefix:@"http"]){
            linkString=[linkString URLEncodedString];
            replacing=[NSString stringWithFormat:@"<a href='http://%@'>%@</a>",linkString,linkString];
        }else if ([linkString hasPrefix:@"#"]){
            linkString=[linkString URLEncodedString];
            replacing=[NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",[linkString URLEncodedString],linkString];
        }
        if (replacing!=nil) {
            text=[text stringByReplacingOccurrencesOfString:linkString withString:replacing];
        }
    }
    return text;
}

@end
