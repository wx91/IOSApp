//
//  HotQueueCell.m
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "HotQueueCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"

@implementation HotQueueCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        [self.contentView addSubview:_imageView];
        //
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+10, 0, screen_width-60, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        //
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, screen_width-60, 20)];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_subTitleLabel];
    }
    return self;
}

-(void)setHotQueue:(HotQueueModel *)hotQueue{
    _hotQueue = hotQueue;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:hotQueue.imageUrl] placeholderImage:nil];
    _titleLabel.text = hotQueue.title;
    _subTitleLabel.text = hotQueue.comment;
}

@end
