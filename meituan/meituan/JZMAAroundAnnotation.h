//
//  JZMAAroundAnnotation.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZMAAroundModel.h"
#import <MAMapKit/MAMapKit.h>

@interface JZMAAroundAnnotation : MAPointAnnotation

@property(nonatomic, strong) JZMAAroundModel *jzmaaroundM;

@end
