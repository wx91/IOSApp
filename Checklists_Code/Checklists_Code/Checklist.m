//
//  Checklist.m
//  Checklists_Code
//
//  Created by wangx on 15/6/24.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "Checklist.h"
#import "ChecklistItem.h"
@implementation Checklist

//计算没有完成的代办事项
-(int)countUncheckedItems{
    int count = 0;
    for(ChecklistItem *item in self.items){
        if(!item.checked){
            count+=1;
        }
    }
    return count;
}

@end
