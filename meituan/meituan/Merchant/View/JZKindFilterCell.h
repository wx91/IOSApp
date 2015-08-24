//
//  JZKindFilterCell.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMerCateGroupModel.h"
/**
 *  查询过滤页面中tableview的Cell
 */
@interface JZKindFilterCell : UITableViewCell{
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UIButton *_numberBtn;
}

@property(nonatomic,strong)JZMerCateGroupModel *groupM;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)frame;


@end
