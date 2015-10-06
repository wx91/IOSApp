//
//  JZMerDetailImageCell.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMerDetailImageCell : UITableViewCell{
    UIImageView *_bigImageView;
    UIImageView *_smallImageView;
    UILabel *_avgPriceLabel;
    UILabel *_shopNameLabel;
}
@property(nonatomic, strong) NSString *BigImgUrl;
@property(nonatomic, strong) NSString *SmallImgUrl;
@property(nonatomic, strong) NSNumber *score;
@property(nonatomic, strong) NSNumber *avgPrice;
@property(nonatomic, strong) NSString *shopName;

@end
