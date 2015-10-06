//
//  Father.m
//  RegexTest
//
//  Created by wangx on 15/8/31.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "Father.h"


@implementation Father

-(instancetype)init{
    self=[super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}

@end
