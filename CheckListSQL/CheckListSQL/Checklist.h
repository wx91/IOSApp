//
//  Checklist.h
//  CheckListSQL
//
//  Created by 王享 on 16/5/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject

@property (nonatomic, assign) NSInteger checklistId;

@property (nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *iconName;


@end
