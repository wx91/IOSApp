//
//  main.m
//  RegexTest
//
//  Created by wangx on 15/8/10.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NSString *text=@"我[围观]你威武，[大笑]";
//        NSString *regex=@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
//        NSArray *matchArray = [text componentsMatchedByRegex:regex];
//        for (NSString *linkString  in matchArray) {
//            NSLog(@"%@",linkString);
//            NSRange range;
//            range.location = 1;
//            range.length = linkString.length - 2;
//            NSString *resultString = [linkString substringWithRange:range];
//            NSLog(@"%@",resultString);
//        }
        NSString *text=@"<a href=\"http://weibo.com\" rel=\"nofollow\">微博 weibo</a>";
            NSString *regex=@">(.+?)<";
            NSArray *array = [text componentsMatchedByRegex:regex];
        for (NSString *linkString  in array) {
                NSRange range;
                range.location = 1;
                range.length = linkString.length - 2;
                NSString *resultString = [linkString substringWithRange:range];
            NSLog(@"%@",resultString);
            
        }
                //>新浪微博<
//                NSString *ret= [array objectAtIndex:0];
//                NSRange range;
//                range.location = 1;
//                range.length = ret.length - 2;
//                NSString *resultString = [ret substringWithRange:range];
//                return resultString;
//            }
    }
    return 0;
}
