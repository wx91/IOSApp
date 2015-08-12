//
//  UIUtils.m
//  WXTime
//
//  Created by wei.chen on 12-7-22.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联ios开发培训中心 All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "UIUtils.h"
#import "NSString+URLEncoding.h"
#import "RegexKitLite.h"

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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat=@"EEE MMM d HH:mm:ss Z yyyy";
    formatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createDate= [formatter dateFromString:datestring];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    
    return text;
}

//正则表达式
+ (NSString *)parseLink:(NSString *)text{
    //解析其中的表情，只显示表情中的文字
//    NSString *regex=@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSString *regex = @"(@[\\u4e00-\\u9fa5\\w\\-]+)|(\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\])|(http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?)|(#([^\\#|.]+)#)|(\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\])";
    NSArray *matchArray = [text componentsMatchedByRegex:regex];
    for (NSString *linkString in matchArray) {
        NSString *replacing = nil;
        if ([linkString hasPrefix:@"@"]) {   //hasPrefix 方法作用：判断以哪个字符串开头
            replacing = [NSString stringWithFormat:@"<a href='user://%@'>%@</a>",[linkString URLEncodedString],linkString];
        }else if([linkString hasPrefix:@"http"]){
            replacing = [NSString stringWithFormat:@"<a href='%@'>%@</a>",linkString,linkString];
        }else if([linkString hasPrefix:@"#"]){
            replacing = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",[linkString URLEncodedString],linkString];
        }else if ([linkString hasPrefix:@"["]){
            NSRange range;
            range.location = 1;
            range.length = linkString.length - 2;
            NSString *resultString = [linkString substringWithRange:range];
            replacing = [NSString stringWithFormat:@"%@",resultString];
        }
//        if (replacing != nil) {
//            text = [text stringByReplacingOccurrencesOfString:linkString withString:replacing];
//        }
    }
    return text;
}

@end
