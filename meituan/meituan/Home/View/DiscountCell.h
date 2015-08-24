//
//  DiscountCell.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DiscountDelegate <NSObject>

@optional
-(void)didSelectUrl:(NSString *)urlStr withType:(NSNumber *)type withId:(NSNumber *)ID withTitle:(NSString *)title;

@end

@interface DiscountCell : UITableViewCell{
    NSMutableArray *_array;
}

@property(nonatomic, strong) NSMutableArray *discountArray;

@property(nonatomic, assign) id<DiscountDelegate> delegate;

@end
