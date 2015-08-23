//
//  RushCell.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RushDealsModel.h"

@protocol RushDelegate <NSObject>

@optional
-(void)didSelectRushIndex:(NSInteger )index;

@end

@interface RushCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray *rushData;

@property(nonatomic, assign) id<RushDelegate> delegate;
@end
