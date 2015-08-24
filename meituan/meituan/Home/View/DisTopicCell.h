//
//  DisTopicCell.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisTopicModel.h"
@interface DisTopicCell : UITableViewCell{
    UIImageView *_topicImage;
    UIView *_lineView;
}

@property(nonatomic, strong) DisTopicModel *disTopic;
@property(nonatomic, strong) NSMutableArray *LabelsArray;

-(void)setTopic:(DisTopicModel *)topic labelsArr:(NSMutableArray *)labels;

@end
