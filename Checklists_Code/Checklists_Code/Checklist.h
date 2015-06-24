//
//  Checklist.h
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject

@property (nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *iconName;

@property(nonatomic,strong) NSMutableArray *items;

//计算没有完成的代办事项
-(int)countUncheckedItems;

@end
