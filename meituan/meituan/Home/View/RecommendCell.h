//
//  RecommendCell.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
#import "DisDealModel.h"

@interface RecommendCell : UITableViewCell{
    NSString *_type;
}

@property(nonatomic, strong) UIImageView *shopImage;
@property(nonatomic, strong) UILabel *shopNameLabel;
@property(nonatomic, strong) UILabel *shopInfoLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *soldedLabel;


@property(nonatomic, strong) RecommendModel *recommendData;

@property(nonatomic, strong) DisDealModel *dealData;


@end
