//
//  ShopRecommendCell.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopRecommendModel.h"

@interface ShopRecommendCell : UITableViewCell{
    UIImageView *_shopImageView;
    UILabel *_shopNameLabel;
    UILabel *_shopInfoLabel;
    UILabel *_shopPriceLabel;
}
@property(nonatomic, strong) ShopRecommendModel *shopRecM;
@end
