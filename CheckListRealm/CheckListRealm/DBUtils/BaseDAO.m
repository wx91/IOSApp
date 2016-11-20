//
//  BaseDAO.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseDAO.h"

#import <Realm/Realm.h>

@implementation BaseDAO

-(RLMRealm *)openRealm{
    return  [RLMRealm defaultRealm];
}

@end
