//
//  JZMerAroundGroupCell.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMerAroundGroupModel.h"
@interface JZMerAroundGroupCell : UITableViewCell{
    UIImageView *_shopImgView;
    UILabel *_shopNameLabel;
    UILabel *_shopSubTitleLabel;
    UILabel *_nowPriceLabel;
    UILabel *_oldPriceLabel;
}

@property(nonatomic, strong) JZMerAroundGroupModel *jzMerAroundM;/**   数据*/

@end
