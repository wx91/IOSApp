//
//  JZMerchantCell.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//
/**
 *  店铺tableView中的Cell
 */
#import <UIKit/UIKit.h>
#import "JZMerchantModel.h"
@interface JZMerchantCell : UITableViewCell{
    UIImageView *_merchantImage;
    UILabel *_merchantNameLabel;//点名
    UILabel *_cateNameLabel;//分类
    UILabel *_evaluateLabel;//评价个数
}

@property(nonatomic,strong)JZMerchantModel *jzMerM;


@end
