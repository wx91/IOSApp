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

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self =[super init])){
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
}

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
