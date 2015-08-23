//
//  DiscountOCViewController.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisTopicModel.h"

@interface DiscountOCViewController : UITableViewController{
    UILabel *_titleLabel;
    
    UIImageView *_topicImage;
    //tableview数据源
    DisTopicModel *_topicData;
    NSMutableArray *_labelArray;
    NSMutableArray *_dealArray;
}

@property(nonatomic, strong) NSString *ID;

@end
