//
//  HomeServiceCell.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeServiceModel.h"

@protocol HomeServiceDelegate <NSObject>

@optional
-(void)didSelectAtIndex:(NSInteger)index;

@end

@interface HomeServiceCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray *homeServiceArray;
@property(nonatomic, assign) id<HomeServiceDelegate> delegate;

@end
