//
//  ImageScrollCell.m
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "ImageScrollCell.h"
#import "Constant.h"

@implementation ImageScrollCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"imageArr:%ld",self.imageArr.count);
        self.imageScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 180) ImageArray:self.imageArr];
        [self.contentView addSubview:self.imageScrollView];
    }
    return self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"imageArr:%ld",self.imageArr.count);
        self.imageScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) ImageArray:self.imageArr];
        [self.contentView addSubview:self.imageScrollView];
    }
    return self;
}

-(void)setImageArray:(NSArray *)imageArray{
    [self.imageScrollView setImageArray:imageArray];
}

-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    [self.imageScrollView setImageArray:imageArr];
}


@end
