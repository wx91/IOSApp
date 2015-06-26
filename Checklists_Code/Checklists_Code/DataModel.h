//
//  DataModel.h
//  Checklists_Code
//
//  Created by wangx on 15/6/26.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic,strong)NSMutableArray *lists;

-(void)saveChecklists;

-(void)sortChecklists;

@end
