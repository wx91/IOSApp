//
//  HotQueueCell.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotQueueModel.h"

@interface HotQueueCell : UITableViewCell{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
}

@property(nonatomic, strong) HotQueueModel *hotQueue;

@end
