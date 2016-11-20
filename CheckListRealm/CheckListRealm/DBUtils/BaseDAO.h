//
//  BaseDAO.h
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface BaseDAO : NSObject{
    RLMRealm *realm;
}
-(RLMRealm *)openRealm;

@end
