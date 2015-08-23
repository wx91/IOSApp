//
//  ImageScrollCell.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@interface ImageScrollCell : UITableViewCell

@property(nonatomic, strong) ImageScrollView *imageScrollView;
@property(nonatomic, strong) NSArray *imageArr;

-(void)setImageArray:(NSArray *)imageArray;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;
@end
